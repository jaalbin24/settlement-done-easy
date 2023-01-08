class SearchSettlementsController < ApplicationController
    before_action :authenticate_user!


    def search
        requesting_user = current_user
        search_results = Settlement.search(requesting_user, allowed_params)

        render json: search_results, only: [:public_number, :claimant_name, :amount], include: [
            adjuster: {
                only: [],
                include: [
                    profile: {only: [:first_name, :last_name]}
                ]
            },
            attorney: {
                only: [],
                include: [
                    profile: {only: [:first_name, :last_name]}
                ]
            }
        ]
    end

    def allowed_params
        params.permit(
            :canceled,
            :active,
            :completed,
            :attorney_public_id,
            :adjuster_public_id,
            :amount_min,
            :amount_max,
            :public_number,
            :time_period,
        )
    end
end