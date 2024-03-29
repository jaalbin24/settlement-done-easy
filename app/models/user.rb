# == Schema Information
#
# Table name: users
#
#  id                          :bigint           not null, primary key
#  activated                   :boolean          default(FALSE), not null
#  business_name               :string
#  current_sign_in_at          :datetime
#  current_sign_in_ip          :string
#  email                       :string           default(""), not null
#  encrypted_password          :string           default(""), not null
#  first_name                  :string
#  last_name                   :string
#  last_sign_in_at             :datetime
#  last_sign_in_ip             :string
#  phone_number                :bigint
#  remember_created_at         :datetime
#  reset_password_sent_at      :datetime
#  reset_password_token        :string
#  role                        :string
#  sign_in_count               :integer          default(0), not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  organization_id             :bigint
#  public_id                   :string
#  stripe_financial_account_id :string
#
# Indexes
#
#  index_users_on_email                        (email) UNIQUE
#  index_users_on_organization_id              (organization_id)
#  index_users_on_reset_password_token         (reset_password_token) UNIQUE
#  index_users_on_stripe_financial_account_id  (stripe_financial_account_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => users.id)
#
class User < ApplicationRecord
    include EnglishLanguage
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

    scope :with_email,          -> (i) {where(email: i)}

    scope :activated,           ->  {where(activated: true)}
    scope :not_activated,       ->  {where(activated: false)}
    scope :members,             ->  {where(role: ["Attorney", "Adjuster"])}
    scope :organizations,       ->  {where(role: ["Law Firm", "Insurance Company"])}
    scope :law_firms,           ->  {where(role: "Law Firm")}
    scope :insurance_companies, ->  {where(role: "Insurance Company")}
    scope :attorneys,           ->  {where(role: "Attorney")}
    scope :adjusters,           ->  {where(role: "Adjuster")}

    validates :role, inclusion: {in: -> (i) {User.roles}} # Useless i variable prevents ArgumentError from being thrown during testing. Do not remove.
    validates :role, inclusion: {in: -> (i) {[i.role_was]}, message: "cannot be changed after creation."}, on: :update
    validates :email, :role, :encrypted_password, presence: true
    validates :stripe_account, absence: {if: :isMember?}
    validates :stripe_account, presence: {if: :isOrganization?}, on: :update
    validates :organization, presence: {if: :isMember?}
    validates :organization, absence: {if: :isOrganization?}
    validates :members, absence: {if: :isMember?}


    validate :name_has_valid_characters
    def name_has_valid_characters
        if !business_name.blank? && isOrganization? && !business_name.tr(" &-", "").match?(/\A[a-zA-Z0-9'-]*\z/)
            errors.add(:business_name, "can only contain letters, numbers, ampersands (&), and hyphens (-)")
        elsif isMember? && !first_name.blank? && !last_name.blank?
            if !first_name.tr(" -", "").match?(/\A[a-zA-Z'-]*\z/)
                errors.add(:first_name, "can only contain letters and hyphens (-)")
            end
            if !last_name.tr(" -", "").match?(/\A[a-zA-Z'-]*\z/)
                errors.add(:last_name, "can only contain letters and hyphens (-)")
            end
        end
    end

    # Organization-type users cannot belong to an organization.
    validates :organization, absence: {if: :isOrganization?, message: "must be nil for organization-type users, not '%{value}'"}
    
    # Member-type users cannot belong to another member-type user.
    validate :member_cannot_belong_to_member
    def member_cannot_belong_to_member
        if !organization.nil?
            errors.add(:organization, "must be an organization-type user") unless organization.isOrganization?
        end
    end

    validate :role_must_match_organization_type
    def role_must_match_organization_type
        if !organization.blank? && !role.blank? && !organization.role.blank?
            errors.add(:organization, "member must have appropriate user role. The role of '#{role}' is invalid for members of #{organization.role.pluralize}") unless (organization.isLawFirm? && isAttorney?) || (organization.isInsuranceCompany? && isAdjuster?)
        end
    end

    has_many(
        :setup_intents,
        class_name: "StripeSetupIntent",
        foreign_key: :created_by_id,
        inverse_of: :created_by,
        dependent: :destroy
    )

    has_one(
        :profile,
        class_name: "UserProfile",
        foreign_key: :user_id,
        dependent: :destroy,
        inverse_of: :user
    )
    accepts_nested_attributes_for :profile
    has_many(
        :documents,
        class_name: "Document",
        foreign_key: :added_by_id,
        inverse_of: :added_by,
        dependent: :nullify
    )
    has_many(
        :payment_methods,
        class_name: "PaymentMethod",
        foreign_key: :added_by_id,
        inverse_of: :added_by,
        dependent: :destroy,
    )
    has_many(
        :a_settlements,
        class_name: 'Settlement',
        foreign_key: :attorney_id,
        inverse_of: :attorney,
        dependent: :destroy
    )

    has_many(
        :ia_settlements,
        class_name: 'Settlement',
        foreign_key: :adjuster_id,
        inverse_of: :adjuster,
        dependent: :destroy
    )

    has_many(
        :a_payments,
        through: :a_settlements,
        source: :payments
    )

    has_many(
        :ia_payments,
        through: :ia_settlements,
        source: :payments
    )

    belongs_to(
        :organization,
        class_name: "User",
        foreign_key: :organization_id,
        inverse_of: :members,
        optional: true
    )

    has_many(
        :members,
        class_name: "User",
        foreign_key: :organization_id,
        inverse_of: :organization,
        dependent: :destroy
    )


    has_many(
        :payment_requests,
        class_name: "PaymentRequest",
        foreign_key: :requester_id,
        inverse_of: :requester,
        dependent: :destroy
    )

    has_many(
        :document_reviews,
        class_name: "DocumentReview",
        foreign_key: :reviewer_id,
        inverse_of: :reviewer,
        dependent: :destroy
    )

    has_one(
        :stripe_account,
        class_name: "StripeAccount",
        foreign_key: :user_id,
        inverse_of: :user,
        dependent: :destroy
    )

    has_many(
        :notifications,
        class_name: "Notification",
        foreign_key: :user_id,
        inverse_of: :user,
        dependent: :destroy
    )

    has_one(
        :settings,
        class_name: "UserSettings",
        foreign_key: :user_id,
        inverse_of: :user,
        dependent: :destroy
    )

    after_commit do
        puts "❤️❤️❤️ User after_commit block"
        unless frozen? # The .frozen? check keeps an error from being thrown when deleting models
            update_activated_attribute
            if activated_changed?
                self.save
                puts "✔️✔️✔️ Account for #{business_name} is activated!" if activated?
            end
        end
    end

    after_create do
        puts "❤️❤️❤️ User after_create block"
        create_settings(UserSettings.default_settings) if settings.nil?
        create_profile() if profile.nil?
        if isOrganization?
            create_stripe_account() if stripe_account.nil?
            # if stripe_financial_account.nil?
            #     build_stripe_financial_account
            # end
        end
        # if isLawFirm? && stripe_financial_account_id.blank?
        #     treasury_account = Stripe::Treasury::FinancialAccount.create(
        #         {
        #             supported_currencies: ['usd'],
        #             features: {
        #                 intra_stripe_flows: {requested: true}, # For recieving money from IC financial account
        #                 outbound_transfers: {ach: {requested: true}}, # For transferring from LF financial account to LF bank account
        #             },
        #         },
        #         {stripe_account: stripe_account_id},
        #     )
        #     self.stripe_financial_account_id = treasury_account.id
        # elsif isInsuranceCompany? && stripe_financial_account_id.blank?
        #     treasury_account = Stripe::Treasury::FinancialAccount.create(
        #         {
        #             supported_currencies: ['usd'],
        #             features: {
        #                 intra_stripe_flows: {requested: true}, # For sending money to LF financial account
        #                 inbound_transfers: {ach: {requested: true}}, # For transferring from IC bank account to IC financial account
        #             },
        #         },
        #         {stripe_account: stripe_account_id},
        #     )
        #     self.stripe_financial_account_id = treasury_account.id
        # end
        # self.save if stripe_financial_account_id_changed?
    end

    before_create do
        puts "❤️❤️❤️ User before_create block"
        if organization_id == 0
            self.organization_id = nil
        end
        if role.blank? && !organization.blank?
            if organization.isLawFirm?
                self.role = "Attorney"
            elsif user.organization.isInsuranceCompany?
                self.role = "Adjuster"
            end
        end
    end

    def self.roles
        ["Adjuster", "Attorney", "Law Firm", "Insurance Company"]
    end

    def update_activated_attribute
        unless isOrganization?
            return
        end
        if stripe_account_onboarded? &&
            has_bank_account? &&
            two_factor_authentication_enabled? &&
            email_verified? &&
            has_member_account?
            self.activated = true
            return
        end
        self.activated = false
        if !stripe_account_onboarded?
            puts "❌❌❌ Account for #{business_name} not activated because stripe account is not onboarded!"
        elsif !has_bank_account?
            puts "❌❌❌ Account for #{business_name} not activated because there is no bank account!"
        elsif !two_factor_authentication_enabled? 
            puts "❌❌❌ Account for #{business_name} not activated because MFA is not enabled!"
        elsif !has_member_account?
            puts "❌❌❌ Account for #{business_name} not activated because there is no member account!"
        elsif !email_verified?
            puts "❌❌❌ Account for #{business_name} not activated because email is not verified!"
        else
            puts "❌❌❌ Account for #{business_name} not activated for an unknown reason!"
        end
    end

    def name
        profile.name
    end

    def activated?
        activated
    end

    def stripe_account_id
        return stripe_account.stripe_id
    end

    def stripe_account_onboarded?
        if stripe_account.nil?
            false
        elsif stripe_account.onboarded?
            true
        else
            false
        end
    end

    def isAttorney?
        return role == "Attorney"
    end

    def isAdjuster?
        return role == "Adjuster"
    end

    def isLawFirm?
        return role == "Law Firm"
    end

    def isInsuranceCompany?
        return role == "Insurance Company"
    end
    
    def isOrganization?
        return isLawFirm? || isInsuranceCompany?
    end

    def isMember?
        return isAttorney? || isAdjuster?
    end

    def lawful?
        return isAttorney? || isLawFirm?
    end

    def insureful?
        return isAdjuster? || isInsuranceCompany?
    end

    def has_bank_account?
        return !bank_accounts.empty?
    end

    def two_factor_authentication_enabled?
        return true
    end

    def has_member_account?
        if isMember?
            return false
        else
            return members.exists?
        end
    end

    def payments
        if isLawFirm?
            return payments_in
        elsif isInsuranceCompany?
            return payments_out
        elsif isAttorney?
            return a_payments
        elsif isAdjuster?
            return ia_payments
        end
    end

    def settlements
        if isAttorney?
            return a_settlements
        elsif isAdjuster?
            return ia_settlements
        elsif isLawFirm?
            attorney_id_array = User.where(organization_id: id).pluck(:id)
            settlements = Settlement.where(attorney_id: attorney_id_array).all
        elsif isInsuranceCompany?
            agent_id_array = User.where(organization_id: id).pluck(:id)
            settlements = Settlement.where(adjuster_id: agent_id_array).all
        end
    end

    def email_verified?
        return true
        # TODO: Add email verification mechanic
    end

    def default_payment_method
        payment_methods.first
    end

    def destroy # Needed so that child models (namely the last bank account) can know when the user is being deleted and delete itself.
        self.mark_for_destruction
        super
    end

    def settlements=(n)
        if isAttorney?
            a_settlements=n
        elsif isAdjuster?
            ia_settlements=n
        end
    end

    def isMemberOf?(u)
        return false if u.nil?
        return false if u.members.nil?
        u.members.include?(self)
    end

    def to_organization
        if isOrganization?
            self
        elsif isMember?
            organization
        else
            raise StandardError.new "Unhandeled role type! User is neither a member nor organization."
        end
    end

    def bank_accounts
        if isOrganization?
            BankAccount.joins(:added_by).where(added_by: {id: id}).or(BankAccount.joins(:added_by).where(added_by: {organization_id: id})).distinct
        else
            payment_methods.bank_accounts
        end
    end
end
