# == Schema Information
#
# Table name: settlements
#
#  id                        :integer          not null, primary key
#  claim_number              :string
#  completed                 :boolean          default(FALSE), not null
#  defendent_name            :string
#  document_approved         :boolean          default(FALSE), not null
#  document_needs_adjustment :boolean          default(FALSE), not null
#  document_signed           :boolean          default(FALSE), not null
#  final_document_approved   :boolean          default(FALSE), not null
#  incident_date             :date
#  incident_location         :string
#  payment_has_error         :boolean          default(FALSE), not null
#  payment_made              :boolean          default(FALSE), not null
#  payment_received          :boolean          default(FALSE), not null
#  plaintiff_name            :string
#  policy_number             :string
#  settlement_amount         :float
#  signature_requested       :boolean          default(FALSE), not null
#  stage                     :integer          default(1), not null
#  status                    :integer          default(1), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  insurance_agent_id        :integer
#  lawyer_id                 :integer
#  stripe_payment_intent_id  :string
#  stripe_price_id           :string
#  stripe_product_id         :string
#
# Indexes
#
#  index_settlements_on_insurance_agent_id  (insurance_agent_id)
#  index_settlements_on_lawyer_id           (lawyer_id)
#
# Foreign Keys
#
#  insurance_agent_id  (insurance_agent_id => users.id)
#  lawyer_id           (lawyer_id => users.id)
#
class Settlement < ApplicationRecord
    belongs_to(
        :lawyer,
        class_name: "User",
        foreign_key: "lawyer_id",
    )

    belongs_to(
        :insurance_agent,
        class_name: "User",
        foreign_key: "insurance_agent_id",
    )

    has_one(
        :release_form,
        class_name: "ReleaseForm",
        foreign_key: "settlement_id",
        inverse_of: :settlement,
    )

    before_destroy do
        release_form.destroy unless release_form == nil
    end

    after_commit do
        if !self.frozen? # The .frozen? check keeps an error from being thrown when deleting settlement models
            self.update_progress
            if self.changed?
                self.save
            end
        end
    end

    before_save do
        # if release_form.changed?
        #     release_from.save
        # end
        if self.claim_number_changed?
            stripe_product = Stripe::Product.create({name: "Settlement for claim ##{self.claim_number}"})
            self.stripe_product_id = stripe_product.id
        end
        if self.settlement_amount_changed?
            stripe_price = Stripe::Price.create({
                unit_amount_decimal: self.settlement_amount * 100,
                currency: "usd",
                product: self.stripe_product_id
            })
            self.stripe_price_id = stripe_price.id
        end
    end

    after_create do
        if self.stripe_price_id == nil
            stripe_product = Stripe::Product.create({name: "Settlement for claim ##{self.claim_number}"})
            stripe_price = Stripe::Price.create({
                unit_amount_decimal: self.settlement_amount * 100,
                currency: "usd",
                product: stripe_product.id
            })
            self.stripe_product_id = stripe_product.id
            self.stripe_price_id = stripe_price.id
            self.save
        end
    end

    def partner_of(user)
        if user.isLawyer?
            return insurance_agent
        elsif user.isInsuranceAgent?
            return lawyer
        end
    end

    def hasDocument?
        if release_form == nil
            return false
        elsif !release_form.pdf.attached?
            return false
        else
            return true
        end
    end

    def status_message
        return SettlementProgress.status_message(self)
    end
    # STAGE 1
        # STATUS 1 = Waiting for document upload.
        # STATUS 2 = Waiting for document approval.
        # STATUS 3 = Document needs adjustment.

    # STAGE 2
        # STATUS 1 = Document approved. Waiting to be sent to claimant.
        # STATUS 2 = DS signature request sent. Waiting for claimant signature.
        # STATUS 3 = Approved by claimant (signed) and waiting for final document review.

    # STAGE 3
        # STATUS 1 = Document w/ signature approved. Waiting for payment.
        # STATUS 2 = Paid. Payment processing.
        # STATUS 3 = Error with payment. Waiting for payment again.
        # STATUS 4 = Payment received. Waiting for Settlement completion.

    # STAGE 4
        # STATUS 1 = Completed
    def update_progress
        if stage == 1
            if !hasDocument?
                self.status = 1
            elsif !document_approved?
                if !document_needs_adjustment?
                    self.status = 2
                else
                    self.status = 3
                end
            elsif document_approved?
                self.stage = 2
                self.status = 1
            end
        elsif stage == 2
            if !document_signed?
                if !signature_requested?
                    self.status = 1
                elsif signature_requested?
                    self.status = 2
                end
            else
                self.status = 3
                if final_document_approved?
                    self.stage = 3
                    self.status = 1
                end
            end
        elsif stage == 3
            if !payment_made?
                self.status = 1
            else
                if !payment_received?
                    if payment_has_error?
                        self.status = 3
                    else
                        self.status = 2
                    end
                else
                    self.status = 4
                    if completed?
                        self.stage = 4
                        self.status = 1
                    end
                end
            end
        end
    end
end
