class SearchSettlementsController < ApplicationController
    include ActionView::Helpers::DateHelper # for the distance_of_time_in_words method
    before_action :authenticate_user!


    def search
        requesting_user = current_user
        search_results = Settlement.search(requesting_user, allowed_params)
        response = search_results.all.map.with_index do |settlement, i|
            {
                public_number: settlement.public_number,
                claimant_name: settlement.claimant_name,
                amount: settlement.amount,
                time_elapsed: distance_of_time_in_words(DateTime.now, settlement.created_at),
                show_path: settlement_show_path(settlement),
                adjuster: {
                    profile: {
                        first_name: settlement.adjuster.profile.first_name,
                        last_name: settlement.adjuster.profile.last_name,
                        show_path: user_profile_show_path(settlement.adjuster.profile),
                    }
                },
                attorney: {
                    profile: {
                        first_name: settlement.attorney.profile.first_name,
                        last_name: settlement.attorney.profile.last_name,
                        show_path: user_profile_show_path(settlement.attorney.profile),
                    }
                }
            }
        end

        puts "RENDERING......... #{response}"
        render json: response
    end

    def allowed_params
        params.permit(
            :canceled,
            :active,
            :completed,
            :needs_document,
            :ready_for_payment,
            :needs_signature,
            :needs_attr_approval_from,
            :needs_document_approval_from,
            :attorney_public_id,
            :adjuster_public_id,
            :amount_min,
            :amount_max,
            :public_number,
            :time_period,
        )
    end
end