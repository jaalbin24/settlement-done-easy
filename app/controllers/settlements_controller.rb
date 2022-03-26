class SettlementsController < ApplicationController
    before_action :authenticate_user!

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
            flash.now[:info] = "Settlement updated"
            render :show
        else
            #
        end
    end

    def start_with_who
        @settlement = Settlement.new
        if current_user.isLawyer?
            @users = User.all_insurance_agents
            render :start_with_who
        elsif current_user.isInsuranceAgent?
            @users = User.all_lawyers
            render :start_with_who
        else
            handle_invalid_request
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
