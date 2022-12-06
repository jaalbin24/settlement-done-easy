class SettlementAttributesReviewsController < ApplicationController
    before_action :authenticate_user!

    # Called by client-side javascript
    def update
        begin
            @review = SettlementAttributesReview.find_by(public_id: params[:id])
            @review.update(allowed_params)
        rescue ActiveRecord::RecordNotFound => e
            head 404
        rescue => e
            head 500
        end
    end

    def allowed_params
        params.require(:settlement_attributes_review).permit(
            :claimant_name_approved,
            :policy_holder_name_approved,
            :claim_number_approved,
            :policy_number_approved,
            :incident_date_approved,
            :incident_location_approved,
            :amount_approved,
            :public_id,
        )
    end
end
