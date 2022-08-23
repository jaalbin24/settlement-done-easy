class SettlementsController < ApplicationController
    include SettlementProgress
    include DsEnvelope
    include DocumentGenerator
    before_action :authenticate_user!

    def new
        if current_user.isAttorney?
            @settlement = Settlement.new
            @users = User.all_insurance_agents
            render :new
        elsif current_user.isInsuranceAgent?
            @settlement = Settlement.new
            @users = User.all_attorneys
            render :new
        else
            handle_invalid_request
        end
    end

    def need_index
        @stage = params[:stage].to_i
        @status = params[:status].to_i
        if SettlementProgress.statusValid?(@stage, @status)
            if current_user.isAttorney?
                @settlements = Settlement.where("stage=?", @stage).and(Settlement.where("status=?", @status).and(Settlement.where("attorney_id=?", current_user.id)))
            elsif current_user.isInsuranceAgent?
                @settlements = Settlement.where("stage=?", @stage).and(Settlement.where("status=?", @status).and(Settlement.where("insurance_agent_id=?", current_user.id)))
            end
            render :need_index
        else
            flash[:error] = "That status is not valid! Stage = #{@stage} Status = #{@status}"
            redirect_back(fallback_location: root_path)
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
        if current_user.isAttorney?
            attorney = current_user
            insurance_agent = partner
        elsif current_user.isInsuranceAgent?
            attorney = partner
            insurance_agent = current_user
        end
        settlement_creation_params = {
            claim_number: settlement_params[:claim_number],
            policy_number: settlement_params[:policy_number],
            dollar_amount: settlement_params[:dollar_amount],
            defendant_name: settlement_params[:defendant_name],
            plaintiff_name: settlement_params[:plaintiff_name],
            incident_date: settlement_params[:incident_date],
            incident_location: settlement_params[:incident_location],
            attorney: attorney,
            insurance_agent: insurance_agent
        }
        settlement = Settlement.new(settlement_creation_params)
        if settlement.save
            flash[:info] = "Started a new settlement with #{partner.full_name}! Click <a href=#{settlement_show_path(settlement)}>here<a> to view it."
            redirect_to settlement_show_url(settlement)
        else
            flash.now[:error] = "#{settlement.errors.full_messages.inspect}"
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
        flash[:info] = "Settlement canceled!"
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

    def execute_payment
        begin
            settlement = Settlement.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        if settlement.has_ongoing_payment?
            flash[:info] = "This settlement already has an ongoing payment."
            redirect_back(fallback_location: root_path)
            return
        elsif settlement.has_completed_payment?
            flash[:info] = "This settlement has already been paid."
            redirect_back(fallback_location: root_path)
            return
        elsif !settlement.documents.exists?
            flash[:info] = "This settlement must have an approved document before payment can be made."
            redirect_back(fallback_location: root_path)
            return
        elsif settlement.documents.unapproved.exists?
            flash[:info] = "All documents must be approved before payment can be made."
            redirect_back(fallback_location: root_path)
            return
        elsif settlement.documents.unsigned.need_signature.exists?
            flash[:info] = "All documents that need a signature must be signed before payment can be made."
            redirect_back(fallback_location: root_path)
            return
        elsif !settlement.insurance_agent.organization.bank_accounts.exists?
            flash[:info] = "You cannot make payments because #{settlement.insurance_agent.organization.full_name} has not set up payment details."
            redirect_back(fallback_location: root_path)
            return
        elsif !settlement.attorney.organization.bank_accounts.exists?
            flash[:info] = "You cannot make payments because #{settlement.attorney.organization.full_name} has not set up payment details."
            redirect_back(fallback_location: root_path)
            return
        elsif !current_user.isInsuranceAgent?
            flash[:info] = "#{current_user.role.pluralize.capitalize} cannot pay settlements."
            redirect_back(fallback_location: root_path)
            return
        end
        settlement.initiate_payment
        redirect_back(fallback_location: root_path)
    end

    def payment_success
        begin
            @settlement = Settlement.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        @settlement.payment_made = true
        @settlement.save
        render :payment_success
    end

    def complete
        begin
            settlement = Settlement.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        settlement.completed = true
        settlement.save
        flash[:success] = "Settlement completed!"
        redirect_back(fallback_location: root_path)
    end

    def generate_document
        begin
            settlement = Settlement.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        document = generate_document_for_settlement(settlement)
        if document.save
            flash[:info] = "Generated new document! Click <a href=#{document_show_path(document)}>here</a> to view it."
        else
            flash[:info] = "A document could not be generated. Try again later."
            puts "⚠️⚠️⚠️ ERROR: #{document.errors.full_messages.inspect}"
        end
        redirect_back(fallback_location: root_path)
    end

    def completed_index
        user = current_user
        if user.isAttorney?
            @settlements = Settlement.where("attorney_id=?", user.id).and(Settlement.where("completed=?", true)).all
        elsif user.isInsuranceAgent?
            @settlements = Settlement.where("insurance_agent_id=?", user.id).and(Settlement.where("completed=?", true)).all
        elsif user.isLawFirm?
            attorney_id_array = User.where(organization_id: user.id).pluck(:id)
            @settlements = Settlement.where(attorney_id: attorney_id_array).and(Settlement.where("completed=?", true)).all
        elsif user.isInsuranceCompany?
            agent_id_array = User.where(organization_id: user.id).pluck(:id)
            @settlements = Settlement.where(insurance_agent_id: agent_id_array).and(Settlement.where("completed=?", true)).all
        end  
    end

    def settlement_params
        params.require(:settlement).permit(
            :claim_number,
            :policy_number,
            :dollar_amount,
            :defendant_name,
            :plaintiff_name,
            :incident_date,
            :incident_location
        )
    end
end
