class SettlementsController < ApplicationController
    include SettlementProgress
    include DsEnvelope
    before_action :authenticate_user!

    def dashboard
        render :dashboard
    end
    
    def new
        if current_user.isLawyer?
            @settlement = Settlement.new
            @users = User.all_insurance_agents
            render :new
        elsif current_user.isInsuranceAgent?
            @settlement = Settlement.new
            @users = User.all_lawyers
            render :new
        else
            handle_invalid_request
        end
    end

    def need_index
        @stage = params[:stage].to_i
        @status = params[:status].to_i
        if SettlementProgress.statusValid?(@stage, @status)
            if current_user.isLawyer?
                @settlements = Settlement.where("stage=?", @stage).and(Settlement.where("status=?", @status).and(Settlement.where("lawyer_id=?", current_user.id)))
            elsif current_user.isInsuranceAgent?
                @settlements = Settlement.where("stage=?", @stage).and(Settlement.where("status=?", @status).and(Settlement.where("insurance_agent_id=?", current_user.id)))
            end
            render :need_index
        else
            flash[:error] = "That status is not valid! Stage = #{@stage} Status = #{@status}"
            redirect_to root_path
        end
    end

    def create
        begin
            partner = User.find(params[:partner_id])
        rescue
            handle_invalid_request
            return
        end
        # HTML in the "new settlement" page can be modified to bypass browser-based param control and cause errors to be thrown
        # server-side. This begin-rescue block handles cases where the user-select field was sabotaged client-side.
        if current_user.isLawyer?
            lawyer = current_user
            insurance_agent = partner
        elsif current_user.isInsuranceAgent?
            lawyer = partner
            insurance_agent = current_user
        end
        settlement_creation_params = {
            claim_number: settlement_params[:claim_number],
            policy_number: settlement_params[:policy_number],
            settlement_amount: settlement_params[:settlement_amount],
            defendent_name: settlement_params[:defendent_name],
            plaintiff_name: settlement_params[:plaintiff_name],
            incident_date: settlement_params[:incident_date],
            incident_location: settlement_params[:incident_location],
            lawyer: lawyer,
            insurance_agent: insurance_agent
        }
        settlement = Settlement.new(settlement_creation_params)
        if settlement.save
            flash[:info] = "Started a new settlement with #{partner.full_name}!"
            redirect_to settlement_show_path(settlement)
        else
            flash.now[:error] = "Settlement not created!"
            render :new
        end
    end

    def show
        begin
            @settlement = Settlement.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
    end

    def destroy
        begin
            settlement = Settlement.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        settlement.destroy
        flash[:info] = "Settlement canceled"
        redirect_to root_path
    end

    def update
        begin
            @settlement = Settlement.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        if @settlement.update(settlement_params)
            flash.now[:info] = "Settlement updated."
            render :show
        else
            flash.now[:error] = "Settlement could not be updated."
        end
    end

    def review_document
        begin
            @settlement = Settlement.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        if !@settlement.hasDocument?
            flash[:error] = "That settlement does not have a document to review. #{@settlement.insurance_agent.full_name} must add one."
            redirect_to settlement_show_path(@settlement)
        else
            render :review_document
        end
    end

    def approve_stage1_document
        begin
            settlement = Settlement.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        settlement.document_needs_adjustment = false
        settlement.document_approved = true
        settlement.save

        flash[:info] = "Document approved! You can now get your client's signature."
        redirect_to settlement_get_client_signature_path(settlement)
    end

    def reject_stage1_document
    end

    def approve_stage2_document
        begin
            settlement = Settlement.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        settlement.final_document_approved = true
        settlement.save

        flash[:info] = "Document approved! #{settlement.insurance_agent.full_name} can now initiate payment."
        redirect_to settlement_show_path(settlement)
    end

    def reject_stage2_document
    end
    
    def get_client_signature
        begin
            @settlement = Settlement.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        render :get_client_signature
    end

    def send_ds_signature_request
        begin
            settlement = Settlement.find(params[:id])
            if params[:client_email] == nil || !params[:client_email].include?("@") || !params[:client_email].include?(".")
                flash.now[:warning] = "You did not provide a valid client email. No email sent."
                render :get_client_signature
                return
            elsif params[:client_name] != settlement.plaintiff_name
                flash[:warning] = "Client's name does not match the plaintiff name given in settlement. No email sent."
                redirect_to root_path
                return
            end
        rescue
            handle_invalid_request
            return
        end
        envelope_args = {
            email_subject: "#{settlement.lawyer.full_name} is requesting a signature.",
            signer_email: params[:client_email],
            signer_name: params[:client_name],
            cc_email: Rails.configuration.APP_EMAIL,
            cc_name: 'Settlement Done Easy',
            status: 'sent'
        }
        envelope_id = create_and_send(settlement.release_form.pdf, envelope_args)
        settlement.signature_requested = true
        settlement.release_form.ds_envelope_id = envelope_id
        if !settlement.release_form.save || !settlement.save
            puts "====================== ERROR SAVING: #{settlement.errors.full_messages.inspect} | #{settlement.release_form.errors.full_messages.inspect}"
        end
        flash[:info] = "Sent signature request to #{params[:client_email]}"
        redirect_to root_path
    end

    def get_ds_envelope_status
        settlement = Settlement.find(params[:id])
        if !settlement.document_signed?
            envelope = retrieve_envelope(settlement.release_form.ds_envelope_id)
            status = JSON.parse(envelope.to_json)['status']
            puts "================================== get_ds_envelope_status: envelope = #{envelope}"
            if status == "completed" 
                temp_file = download_document(settlement.release_form.ds_envelope_id)
                settlement.release_form.pdf.attach(io: temp_file.open, filename: settlement.release_form.pdf_file_name, content_type: "application/pdf")
                settlement.document_signed = true
                sleep(7)
                settlement.save
            end
        end
        redirect_to root_path
    end

    def review_final_document
        begin
            @settlement = Settlement.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        if !@settlement.hasDocument?
            flash[:error] = "That settlement does not have a document to review. #{@settlement.insurance_agent.full_name} must add one."
            redirect_to settlement_show_path(@settlement)
        else
            render :review_final_document
        end
          
    end

    def settlement_params
        params.require(:settlement).permit(
            :claim_number,
            :policy_number,
            :settlement_amount,
            :defendent_name,
            :plaintiff_name,
            :incident_date,
            :incident_location
        )
    end
end
