class SettlementsController < ApplicationController
    # before_action :authenticate_user!
    def new
        if current_user != nil
            @settlement = Settlement.new
            if current_user.isLawyer?
                @users = User.all_insurance_agents
            elsif current_user.isInsuranceAgent?
                @users = User.all_lawyers
            else
                @users = nil
            end
            render :new
        else
            redirect_to release_form_index_url
        end
    end

    def create
        user = current_user
        user.settlements.build(settlement_params)
    end

    def start_with_who
        if current_user != nil
            @settlement = Settlement.new
            if current_user.isLawyer?
                @users = User.all_insurance_agents
            elsif current_user.isInsuranceAgent?
                @users = User.all_lawyers
            else
                @users = nil
            end
            render :start_with_who
        else
            redirect_to release_form_index_url
        end
    end

    def settlement_params(params)
        params.require(:settlement).permit(
            :lawyer,
            :insurance_agent,
            :claim_number,
            :policy_number,
            :settlement_amount,
            :defendent_name,
            :plaintiff_name
        )
    end
end
