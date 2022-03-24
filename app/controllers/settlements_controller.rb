class SettlementsController < ApplicationController
    before_action :authenticate_user!
    def partner_selected
        session['new_settlement_partner_id'] = params[:settlement][:insurance_agent]
        redirect_to settlement_new_path
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
            flash[:error] = "You should not be here!"
            redirect_to root_path
        end
    end

    def create
        user = current_user
        settlement = user.settlements.build(settlement_params)
        if settlement.save
            flash[:success] = "Settlement started with #{settlement.partner_of(user)}"
            redirect_to root_path
        else
            flash.now[:error] = "Settlement not created!"
            render :new
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
            redirect_to root_path
        end
    end

    def settlement_params
        params.require(:settlement).permit(
            :lawyer,
            :insurance_agent,
            :claim_number,
            :policy_number,
            :settlement_amount,
            :defendent_name,
            :plaintiff_name,
            :partner_id
        )
    end
end
