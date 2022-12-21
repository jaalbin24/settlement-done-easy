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
#  public_id     :string
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

    scope :active,      ->      {where(status: "Requested").or(where(status: "Accepted"))}
    scope :unanswered,  ->      {where(status: "Requested")}

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

    validates :status, inclusion: {in: ["Requested", "Denied", "Accepted"]}
    validates :requester, :accepter, presence: true
    validate :requester_is_affiliated_with_settlement
    def requester_is_affiliated_with_settlement
        errors.add(:requester, "is not affiliated with that settlement.") unless [settlement.adjuster, settlement.attorney].include?(requester)
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
        puts "❤️❤️❤️ PaymentRequest before_validation block"
        # Initialize accepter reference
        if requester.isAttorney?
            self.accepter = settlement.adjuster
        elsif requester.isAdjuster?
            self.accepter = settlement.attorney
        end
    end

    before_save do
        puts "❤️❤️❤️ PaymentRequest before_save block"
        unless log_book.nil?
            generate_any_logs
            log_book.save
        end
    end

    before_create do
        puts "❤️❤️❤️ PaymentRequest before_create block"
        if settlement.has_unanswered_payment_request?
            raise SafetyError::SettlementSafetyError.new "You have already requested payment for this settlement. Wait until that request is answered before requesting payment again."
        end
        create_log_book_model_if_self_lacks_one
    end
    
    after_commit do
        puts "❤️❤️❤️ PaymentRequest after_commit block"
        settlement.save
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
