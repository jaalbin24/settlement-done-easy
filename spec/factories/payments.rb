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
#  destination_id              :bigint
#  log_book_id                 :bigint
#  public_id                   :string
#  settlement_id               :bigint
#  source_id                   :bigint
#  stripe_inbound_transfer_id  :string
#  stripe_outbound_payment_id  :string
#  stripe_outbound_transfer_id :string
#
# Indexes
#
#  index_payments_on_destination_id               (destination_id)
#  index_payments_on_log_book_id                  (log_book_id)
#  index_payments_on_settlement_id                (settlement_id)
#  index_payments_on_source_id                    (source_id)
#  index_payments_on_stripe_inbound_transfer_id   (stripe_inbound_transfer_id) UNIQUE
#  index_payments_on_stripe_outbound_payment_id   (stripe_outbound_payment_id) UNIQUE
#  index_payments_on_stripe_outbound_transfer_id  (stripe_outbound_transfer_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (destination_id => bank_accounts.id)
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (settlement_id => settlements.id)
#  fk_rails_...  (source_id => bank_accounts.id)
#
FactoryBot.define do
    factory :payment, class: "Payment" do
        association :source, factory: :bank_account_for_insurance_company
        association :destination, factory: :bank_account_for_law_firm
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
                "========> source: #{p.source.user.full_name}\n"+
                "========> destination: #{p.destination.user.full_name}\n"+
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
                    @adjuster = select_random_insurance_agent_or_create_one_if_none_exist
                    p.settlement = build(:settlement, attorney: @attorney, insurance_agent: @adjuster) 
                end
            end
            after(:create) do |p, e|
                puts "🤖🤖🤖 payment:from_the_ground_up after(:create) block"
                # Ensure this payment model is the only one attached to the settlement
                destination = p.settlement.attorney.organization.default_bank_account
                source = p.settlement.insurance_agent.organization.default_bank_account
                p.settlement.payments.excluding(p).each do |destroy_me|
                    destroy_me.destroy!
                end
                noahs_ark = [p.settlement.attorney, p.settlement.insurance_agent, p.settlement.attorney.organization, p.settlement.insurance_agent.organization]
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
                @adjuster = select_random_insurance_agent_or_create_one_if_none_exist
                p.settlement = build(:settlement, attorney: @attorney, insurance_agent: @adjuster) 
            end
            if e.source.nil?
                p.source = build(:bank_account_for_insurance_company, user: @attorney.organization)
            end
            if e.destination.nil?
                p.destination = build(:bank_account_for_law_firm, user: @attorney.organization)
            end
            puts "========> PAYMENT before building!\n"+
            "========> source: #{p.source.user.full_name}\n"+
            "========> destination: #{p.destination.user.full_name}\n"+
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
                destination = p.settlement.attorney.organization.default_bank_account
                source = p.settlement.insurance_agent.organization.default_bank_account
                atties = p.attributes
                atties[:source] = source
                atties[:destination] = destination
                p.settlement.payments.without(p).each do |p|
                    p.destroy!
                end
                p.settlement.touch # Touch the settlement to make self-correcting callbacks run
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
                destination = p.settlement.attorney.organization.default_bank_account
                source = p.settlement.insurance_agent.organization.default_bank_account
                atties = p.attributes
                atties[:source] = source
                atties[:destination] = destination
                p.settlement.payments.without(p).each do |p|
                    p.destroy!
                end
                p.settlement.touch # Touch the settlement to make self-correcting callbacks run
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
