# == Schema Information
#
# Table name: stripe_accounts
#
#  id                                   :bigint           not null, primary key
#  card_payments_enabled                :boolean
#  transfers_enabled                    :boolean
#  treasury_enabled                     :boolean
#  us_bank_account_ach_payments_enabled :boolean
#  created_at                           :datetime         not null
#  updated_at                           :datetime         not null
#  public_id                            :string
#  stripe_id                            :string
#  user_id                              :bigint
#
# Indexes
#
#  index_stripe_accounts_on_stripe_id  (stripe_id) UNIQUE
#  index_stripe_accounts_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class StripeAccount < ApplicationRecord
    has_many(
        :requirements,
        class_name: "StripeAccountRequirement",
        foreign_key: "stripe_account_id",
        inverse_of: :stripe_account,
        dependent: :destroy
    )

    belongs_to(
        :user,
        class_name: "User",
        foreign_key: "user_id",
        inverse_of: :stripe_account
    )

    validates :stripe_id, inclusion: {in: -> (i) {[i.stripe_id_was]}, message: "cannot be changed after creation."}, on: :update
    validates :user, presence: true

    before_validation do
        if stripe_id.blank?
            puts "STRIPE_ID is BLANK"
            # TODO: If this call to Stripe fails for network reasons, add a job to ActiveJobs to retry later.
            account = Stripe::Account.create({
                type: "custom",
                country: "US",
                capabilities: {
                    treasury: {requested: true},
                    us_bank_account_ach_payments: {requested: true},
                    card_payments: {requested: true},
                    transfers: {requested: true},
                },
                business_type: "company",
                business_profile: {url: "http://settlementdoneeasy.com/"},
            })
            self.stripe_id = account.id
            sync_with(account)
        end
    end

    before_create do
        puts "❤️❤️❤️ StripeAccount before_create block"
        sync_with_stripe unless Rails.env.test? # This 'unless' check was added to make tests run faster.
    end

    def sync_with_stripe
        puts "SYNC_WITH_STRIPE EXECUTED"
        if stripe_id.blank?
            raise StandardError.new "Cannot sync Stripe account without a Stripe Connect account ID."
            return
        end
        account = Stripe::Account.retrieve(stripe_id)
        sync_with(account)
    end

    def sync_with(account)
        puts "SYNC_WITH EXECUTED"
        if stripe_id != account.id
            raise StandardError.new "ID mismatch! Cannot sync Stripe account with an account that has a different ID."
            return
        end
        sync_requirements(account)
        sync_capabilities(account)
    end

    def card_payments_enabled?
        return card_payments_enabled
    end

    def transfers_enabled?
        return transfers_enabled
    end

    def us_bank_account_ach_payments_enabled?
        return us_bank_account_ach_payments_enabled
    end

    def treasury_enabled?
        return treasury_enabled
    end

    def onboarded?
        return !requirements.besides_external_account.exists?
    end

    private

    def sync_requirements(account)
        puts "SYNC REQUIREMENTS"
        # Get a hash of all Stripe-side requirements
        account_requirements_hash = account.requirements.to_h
        account_requirements_hash.keys.each do |status|
            # The hash will contain keys that do not contain requirements such as "current_deadline" and "alternatives". This
            # if-statement ensures the key is one that is expected to have required_items in it.
            if StripeAccountRequirement.statuses.include?(status.to_s)
                stripe_side_required_items_array = account_requirements_hash[status].to_a
                # Remove any SDE-side requirements that do not exist Stripe-side.
                requirements.with_status(status.to_s).without_required_item(stripe_side_required_items_array).delete_all
                unless requirements.with_status(status.to_s).count == account_requirements_hash[status].length
                    # Add any Stripe-side requirements that do not already exist SDE-side
                    sde_side_required_items_array = requirements.with_status(status.to_s).pluck(:required_item).to_a
                    additional_required_items_array = stripe_side_required_items_array - sde_side_required_items_array
                    new_requirements_array = Array.new(additional_required_items_array.length) do |i|
                        {required_item: additional_required_items_array[i], status: status.to_s}
                    end
                    requirements.build(new_requirements_array)
                end
            end
        end
    end

    def sync_capabilities(account)
        puts "SYNC CAPABILITIES"
        self.card_payments_enabled = account.capabilities.card_payments == "active"
        self.transfers_enabled = account.capabilities.transfers == "active"
        self.treasury_enabled = account.capabilities.treasury == "active"
        self.us_bank_account_ach_payments_enabled = account.capabilities.us_bank_account_ach_payments == "active"
    end
end