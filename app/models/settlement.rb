# == Schema Information
#
# Table name: settlements
#
#  id                       :bigint           not null, primary key
#  claim_number             :string
#  completed                :boolean          default(FALSE), not null
#  defendant_name           :string
#  incident_date            :date
#  incident_location        :string
#  payment_has_error        :boolean          default(FALSE), not null
#  payment_made             :boolean          default(FALSE), not null
#  payment_received         :boolean          default(FALSE), not null
#  plaintiff_name           :string
#  policy_number            :string
#  settlement_amount        :float
#  signature_requested      :boolean          default(FALSE), not null
#  stage                    :integer          default(1), not null
#  status                   :integer          default(1), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  attorney_id              :bigint
#  insurance_agent_id       :bigint
#  stripe_payment_intent_id :string
#  stripe_price_id          :string
#  stripe_product_id        :string
#
# Indexes
#
#  index_settlements_on_attorney_id         (attorney_id)
#  index_settlements_on_insurance_agent_id  (insurance_agent_id)
#
# Foreign Keys
#
#  fk_rails_...  (attorney_id => users.id)
#  fk_rails_...  (insurance_agent_id => users.id)
#
class Settlement < ApplicationRecord
    include DocumentGenerator
    validates :settlement_amount, presence: true
    validates :completed, inclusion: {in: [false], unless: :payment_received, message: "cannot be true when payment received is false"}
    validates :payment_received, inclusion: {in: [false], unless: :payment_made, message: "cannot be true when payment made is false"}
    validates :payment_has_error, inclusion: {in: [false], unless: :payment_made, message: "cannot be true when payment made is false"}

    belongs_to(
        :attorney,
        class_name: "User",
        foreign_key: "attorney_id",
    )

    belongs_to(
        :insurance_agent,
        class_name: "User",
        foreign_key: "insurance_agent_id",
    )

    has_many(
        :documents,
        class_name: "Document",
        foreign_key: "settlement_id",
        inverse_of: :settlement,
        dependent: :destroy
    )

    after_create do
        generate_document_for_settlement(self)
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
        if self.claim_number_changed? && self.stripe_product_id != nil
            stripe_product = Stripe::Product.create({name: "Settlement for claim ##{self.claim_number}"})
            self.stripe_product_id = stripe_product.id
        end
        if self.settlement_amount_changed? && self.stripe_price_id != nil
            stripe_price = Stripe::Price.create({
                unit_amount_decimal: self.settlement_amount * 100,
                currency: "usd",
                product: self.stripe_product_id
            })
            self.stripe_price_id = stripe_price.id
        end
    end

    def init_stripe_data
        if self.stripe_price_id == nil || self.stripe_price_id == nil
            stripe_product = Stripe::Product.create({name: "Settlement for claim #{self.claim_number}"})
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
        if user.isAttorney?
            return insurance_agent
        elsif user.isInsuranceAgent?
            return attorney
        end
    end

    def has_documents?
        if documents == nil || documents.size == 0
            return false
        else
            return true
        end
    end

    def generated_document_file_name
        "#{self.claim_number}_release.pdf"
    end

    def status_message
        return SettlementProgress.status_message(self)
    end

    def has_approved_and_signed_document?
        documents.each do |d|
            if d.approved? && d.signed?
                return true
            end
        end
        return false
    end

    def has_approved_document?
        documents.each do |d|
            if d.approved?
                return true
            end
        end
        return false
    end

    def has_waiting_document?
        documents.each do |d|
            if !d.approved? && !d.rejected?
                return true
            end
        end
        return false
    end

    def has_document_with_signature_request?
        documents.each do |d|
            if d.ds_envelope_id != nil
                return true
            end
        end
        return false
    end

    def has_unapproved_signed_document?
        documents.each do |d|
            if !d.approved? && d.signed?
                return true
            end
        end
        return false
    end

    def document_with_signature_request
        documents.each do |d|
            if d.ds_envelope_id != nil
                return d
            end
        end
    end

    def document_that_needs_signature
        documents.each do |d|
            if d.approved? && !d.signed? && d.ds_envelope_id == nil
                return d
            end
        end
    end

    def first_waiting_document
        documents.each do |d|
            if !d.approved? && !d.rejected?
                return d
            end
        end
    end
    # STAGE 1
        # STATUS 1 = Waiting for document upload.
        # STATUS 2 = Document needs approval.
        # STATUS 3 = Document rejected. New document must be uploaded or current document must be approved.

    # STAGE 2
        # STATUS 1 = Document approved. Needs signature.
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
        if !has_documents?
            self.stage = 1
            self.status = 1
        elsif !has_approved_document?
            self.stage = 1
            if has_waiting_document?
                self.status = 2
            else
                self.status = 3
            end
        elsif !has_approved_and_signed_document?
            self.stage = 2
            self.status = 1
            if has_document_with_signature_request?
                self.status = 2
            elsif has_unapproved_signed_document?
                self.status = 3
            end
        elsif !payment_made?
            self.stage = 3
            self.status = 1
        elsif !payment_received?
            self.stage = 3
            self.status = 2
        elsif !completed?
            self.stage = 3
            self.status = 4
        elsif completed?
            self.stage = 4
            self.status = 1
        end
    end
end
