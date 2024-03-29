# == Schema Information
#
# Table name: payments
#
#  id                          :bigint           not null, primary key
#  amount                      :float            not null
#  completed_at                :datetime
#  started_at                  :datetime
#  status                      :string           not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  log_book_id                 :bigint
#  public_id                   :string
#  settlement_id               :bigint
#  stripe_inbound_transfer_id  :string
#  stripe_outbound_payment_id  :string
#  stripe_outbound_transfer_id :string
#
# Indexes
#
#  index_payments_on_log_book_id                  (log_book_id)
#  index_payments_on_settlement_id                (settlement_id)
#  index_payments_on_stripe_inbound_transfer_id   (stripe_inbound_transfer_id) UNIQUE
#  index_payments_on_stripe_outbound_payment_id   (stripe_outbound_payment_id) UNIQUE
#  index_payments_on_stripe_outbound_transfer_id  (stripe_outbound_transfer_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (settlement_id => settlements.id)
#
FactoryBot.define do
    factory :payment, class: "Payment" do
        association :settlement
        amount {}
        status {"Not sent"}
        stripe_inbound_transfer_id {}
        stripe_outbound_payment_id {}
        stripe_outbound_transfer_id {}

        after(:create) do |p, e|
            puts "🤖🤖🤖 payment after(:create) block"
            if p.settlement.payments.size > 1
                p.settlement.payments.without(p).each do |p|
                    p.destroy!
                end
                p.settlement.touch
            end
            puts "========> PAYMENT created!\n"+
                "========> p.to_json: #{p.to_json}\n"+
                "========> p.settlement.to_json: #{p.settlement.to_json}\n"+
                "========> p.settlement.payments.size: #{p.settlement.payments.size}\n"+
                "========> status: #{p.status}\n"+
                "========> Payment.all.size: #{Payment.all.size}\n"
        end

        # from_the_ground_up controls the creation of additional models necessary for more realistic 
        # testing such as settlements, users, and bank accounts
        trait :from_the_ground_up do
            before(:build) do |p, e|
                puts "🤖🤖🤖 payment:from_the_ground_up before(:build) block"
                if e.settlement.nil?
                    @attorney = select_random_attorney_or_create_one_if_none_exist
                    @adjuster = select_random_adjuster_or_create_one_if_none_exist
                    p.settlement = build(:settlement, attorney: @attorney, adjuster: @adjuster) 
                end
            end
            after(:create) do |p, e|
                puts "🤖🤖🤖 payment:from_the_ground_up after(:create) block"
                # Ensure this payment model is the only one attached to the settlement
                p.settlement.payments.excluding(p).each do |destroy_me|
                    destroy_me.destroy!
                end
                noahs_ark = [p.settlement.attorney, p.settlement.adjuster, p.settlement.attorney.organization, p.settlement.adjuster.organization]
                User.all.excluding(noahs_ark).each do |u|
                    u.destroy!
                end
                p.settlement.touch # Touch the settlement to make self-correcting callbacks run
            end
        end

        before(:build) do |p, e|
            puts "🤖🤖🤖 payment before(:build) block"
            if e.settlement.nil? # If creation started from the payment factory
                @attorney = select_random_attorney_or_create_one_if_none_exist
                @adjuster = select_random_adjuster_or_create_one_if_none_exist
                p.settlement = build(:settlement, attorney: @attorney, adjuster: @adjuster) 
            end
            puts "========> PAYMENT before building!\n"+
            "========> p.to_json: #{p.to_json}\n"+
            "========> p.settlement.to_json: #{p.settlement.to_json}\n"+
            "========> p.settlement.payments.size: #{p.settlement.payments.size}\n"+
            "========> status: #{p.status}\n"+
            "========> Payment.all.size: #{Payment.all.size}\n"
        end

        trait :processing do
            stripe_inbound_transfer_id {"FakeInboundTransferId"}
            status {"Processing"}
            after(:create) do |p, e|
                puts "🤖🤖🤖 payment:processing after(:create) block"
                # Ensure this payment model is the only one attached to the settlement
            end
        end

        trait :completed do
            stripe_inbound_transfer_id {"FakeInboundTransferId"}
            stripe_outbound_payment_id {"FakeOutboundPaymentId"}
            stripe_outbound_transfer_id {"FakeOutboundTransferId"}
            status {"Complete"}
            after(:create) do |p, e|
                puts "🤖🤖🤖 payment:completed after(:create) block"
                # Ensure this payment model is the only one attached to the settlement
            end
        end

        trait :failed do
            stripe_inbound_transfer_id {"FakeInboundTransferId"}
            status {"Failed"}
        end

        trait :canceled do
            stripe_inbound_transfer_id {"FakeInboundTransferId"}
            status {"Canceled"}
        end
    end
end
