# == Schema Information
#
# Table name: payment_requests
#
#  id            :bigint           not null, primary key
#  status        :string           default("Requested"), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  accepter_id   :bigint
#  log_book_id   :bigint
#  requester_id  :bigint
#  settlement_id :bigint
#
# Indexes
#
#  index_payment_requests_on_accepter_id    (accepter_id)
#  index_payment_requests_on_log_book_id    (log_book_id)
#  index_payment_requests_on_requester_id   (requester_id)
#  index_payment_requests_on_settlement_id  (settlement_id)
#
# Foreign Keys
#
#  fk_rails_...  (accepter_id => users.id)
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (requester_id => users.id)
#  fk_rails_...  (settlement_id => settlements.id)
#
class PaymentRequest < ApplicationRecord

    scope :active,      ->      {where(status: "Requested").or(where(status: "Postponed").or(where(status: "Accepted")))}
    scope :unanswered,  ->      {where(status: "Requested").or(where(status: "Postponed"))}

    belongs_to(
        :requester,
        class_name: "User",
        foreign_key: "requester_id"
    )

    belongs_to(
        :accepter,
        class_name: "User",
        foreign_key: "accepter_id"
    )

    belongs_to(
        :settlement,
        class_name: "Settlement",
        foreign_key: "settlement_id"
    )

    belongs_to(
        :log_book,
        class_name: "LogBook",
        foreign_key: "log_book_id",
        dependent: :destroy,
        optional: true
    )

    validates :status, inclusion: {in: ["Requested", "Postponed", "Denied", "Accepted"]}
    validate :requester_is_affiliated_with_settlement
    def requester_is_affiliated_with_settlement
        errors.add(:requester, "is not affiliated with that settlement.") unless settlement.insurance_agent == requester || settlement.attorney == requester
    end

    validate :settlement_has_one_or_less_unanswered_payment_request
    def settlement_has_one_or_less_unanswered_payment_request
        errors.add(:settlement, "can only have one unanswered payment request at a time.") unless settlement.payment_requests.unanswered.size <= 1
    end

    validate :new_record_must_have_status_of_requested
    def new_record_must_have_status_of_requested
        errors.add(:status, "must be set to \"Requested\" when creating new PaymentRequests.") if new_record? && status != "Requested"
    end

    before_validation do
        # Initialize accepter attribute
        if requester.isAttorney?
            self.accepter = settlement.insurance_agent
        elsif requester.isInsuranceAgent?
            self.accepter = settlement.attorney
        end
    end

    before_save do
        create_log_book_model_if_self_lacks_one
        generate_any_logs
        log_book.save!
    end

    def generate_any_logs
        if self.new_record?
            log_book.entries.build(
                user: requester,
                message: "#{requester.full_name} requested payment."
            )
        end
        if status_changed?
            if accepted?
                log_book.entries.build(
                    user: accepter,
                    message: "#{accepter.full_name} accepted the payment request."
                )
            elsif denied?
                log_book.entries.build(
                    user: accepter,
                    message: "#{accepter.full_name} accepted the payment request."
                )
            end
        end
    end

    def create_log_book_model_if_self_lacks_one
        self.log_book = LogBook.create! if log_book.nil?
    end
    
    def accept
        self.status = "Accepted"
        return self.save
    end

    def deny
        self.status = "Denied"
        return self.save
    end

    def denied?
        return status == "Denied"
    end

    def accepted?
        return status == "Accepted"
    end
end
