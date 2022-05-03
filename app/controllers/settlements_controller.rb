class SettlementsController < ApplicationController
    include SettlementProgress
    include DsEnvelope
    before_action :authenticate_user!

    def dashboard
        render :dashboard
    end
    
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
            settlement_amount: settlement_params[:settlement_amount],
            defendant_name: settlement_params[:defendant_name],
            plaintiff_name: settlement_params[:plaintiff_name],
            incident_date: settlement_params[:incident_date],
            incident_location: settlement_params[:incident_location],
            attorney: attorney,
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
            settlement = Settlement.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        if !settlement.has_documents?
            flash[:error] = "This settlement does not have a document to review."
            redirect_to settlement_show_path(settlement)
        else
            redirect_to document_show_url(settlement.first_waiting_document)
        end
    end

    def payment_success
        begin
            @settlement = Settlement.find(params[:id])
        rescue
            handle_invalid_request
            return
        end
        stripe_payment_intent = Stripe::PaymentIntent.retrieve(@settlement.stripe_payment_intent_id)
        if stripe_payment_intent.status == "processing" || stripe_payment_intent.status == "succeeded"
            @settlement.payment_made = true
            if !@settlement.save
                puts "====================== ERROR SAVING: #{@settlement.errors.full_messages.inspect}"
            end
            render :payment_success
        end
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
        redirect_to settlement_show_url(settlement)
    end

    def settlement_params
        params.require(:settlement).permit(
            :claim_number,
            :policy_number,
            :settlement_amount,
            :defendant_name,
            :plaintiff_name,
            :incident_date,
            :incident_location
        )
    end
end
