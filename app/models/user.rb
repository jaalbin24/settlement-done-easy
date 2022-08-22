# == Schema Information
#
# Table name: users
#
#  id                          :bigint           not null, primary key
#  business_name               :string
#  current_sign_in_at          :datetime
#  current_sign_in_ip          :string
#  email                       :string           default(""), not null
#  encrypted_password          :string           default(""), not null
#  first_name                  :string
#  last_name                   :string
#  last_sign_in_at             :datetime
#  last_sign_in_ip             :string
#  remember_created_at         :datetime
#  reset_password_sent_at      :datetime
#  reset_password_token        :string
#  role                        :string
#  sign_in_count               :integer          default(0), not null
#  stripe_account_onboarded    :boolean          default(FALSE), not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  organization_id             :bigint
#  stripe_account_id           :string
#  stripe_financial_account_id :string
#
# Indexes
#
#  index_users_on_email                        (email) UNIQUE
#  index_users_on_organization_id              (organization_id)
#  index_users_on_reset_password_token         (reset_password_token) UNIQUE
#  index_users_on_stripe_account_id            (stripe_account_id) UNIQUE
#  index_users_on_stripe_financial_account_id  (stripe_financial_account_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => users.id)
#
class User < ApplicationRecord
  include EnglishLanguageSupport
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  scope :with_stripe_id, -> (stripe_id) {where(stripe_account_id: stripe_id)}

  validates :role, inclusion: {in: ["Insurance Agent", "Attorney", "Law Firm", "Insurance Company", "Dummy"]}
  validates :email, :role, :encrypted_password, presence: true
  validates :first_name, :last_name, presence: {unless: :isOrganization?}
  validates :first_name, :last_name, absence: {if: :isOrganization?}
  validates :business_name, presence: {if: :isOrganization?}
  validates :business_name, absence: {unless: :isOrganization?}

  validate :name_has_valid_characters
  def name_has_valid_characters
    if !business_name.blank? && isOrganization? && !business_name.tr(" &-", "").match?(/\A[a-zA-Z0-9'-]*\z/)
      errors.add(:business_name, "can only contain letters, numbers, ampersands (&), and hyphens (-)")
    elsif !isOrganization?
      if first_name.blank? && !first_name.tr(" -", "").match?(/\A[a-zA-Z'-]*\z/)
        errors.add(:first_name, "can only contain letters and hyphens (-)")
      end
      if last_name.blank? && !last_name.tr(" -", "").match?(/\A[a-zA-Z'-]*\z/)
        errors.add(:last_name, "can only contain letters and hyphens (-)")
      end
    end
  end

  # Organization-type users cannot belong to an organization.
  validates :organization, absence: {if: :isOrganization?, message: "must be nil for organization-type users, not '%{value}'"}
  
  # Stripe data constraints.
  validates :stripe_account_id, absence: {unless: :isOrganization?, message: "must be nil for non-organization-type users, not '%{value}'"}

  # Member-type users cannot belong to another member-type user.
  validate :member_cannot_belong_to_member
  def member_cannot_belong_to_member
    if !organization.nil?
      errors.add(:organization, "must be an organization-type user") unless organization.isOrganization?
    end
  end

  validate :role_must_match_organization_type
  def role_must_match_organization_type
    if !organization.blank? && !role.blank?
      errors.add(:organization, "member must have appropriate user role. The role of '#{role}' is invalid for members of #{organization.role.pluralize}") unless (organization.isLawFirm? && isAttorney?) || (organization.isInsuranceCompany? && isInsuranceAgent?)
    end
  end

  has_many(
    :comments,
    class_name: 'Comment',
    foreign_key: 'user_id',
    inverse_of: :author,
    dependent: :destroy
  )

  has_many(
    :a_settlements,
    class_name: 'Settlement',
    foreign_key: 'attorney_id',
    inverse_of: :attorney
  )

  has_many(
    :ia_settlements,
    class_name: 'Settlement',
    foreign_key: 'insurance_agent_id',
    inverse_of: :insurance_agent
  )

  has_many(
    :a_payments,
    through: :a_settlements,
    source: :payment
  )

  has_many(
    :ia_payments,
    through: :ia_settlements,
    source: :payment
  )

  belongs_to(
    :organization,
    class_name: "User",
    foreign_key: "organization_id",
    inverse_of: :members,
    optional: true
  )

  has_many(
    :members,
    class_name: "User",
    foreign_key: "organization_id",
    inverse_of: :organization,
    dependent: :destroy
  )

  has_many(
    :bank_accounts,
    class_name: "BankAccount",
    foreign_key: "user_id",
    inverse_of: :user,
    dependent: :destroy
  )

  has_many(
    :payments_out,
    through: :bank_accounts,
    source: :payments_out
  )

  has_many(
    :payments_in,
    through: :bank_accounts,
    source: :payments_in
  )

  has_many(
    :payment_requests,
    class_name: "PaymentRequest",
    foreign_key: "requester_id",
    inverse_of: :requester,
    dependent: :destroy
  )

  has_many(
    :document_reviews,
    class_name: "DocumentReview",
    foreign_key: "reviewer_id",
    inverse_of: :reviewer,
    dependent: :destroy
  )

  after_create do |user|
    if user.isOrganization? && user.stripe_account_id.blank?
      connect_account = Stripe::Account.create({
        type: "custom",
        country: "US",
        email: user.email,
        capabilities: {
          treasury: {requested: true},
          us_bank_account_ach_payments: {requested: true},
          card_payments: {requested: true},
          transfers: {requested: true},
        },
        business_type: "company",
        business_profile: {url: "http://settlementdoneeasy.com/"},
      })
      user.stripe_account_id = connect_account.id
    end
    if user.isLawFirm? && user.stripe_financial_account_id.blank?
      treasury_account = Stripe::Treasury::FinancialAccount.create({
          supported_currencies: ['usd'],
          features: {
            intra_stripe_flows: {requested: true}, # For recieving money from IC financial account
            outbound_transfers: {ach: {requested: true}}, # For transferring from LF financial account to LF bank account
          },
        },
        {stripe_account: user.stripe_account_id},
      )
    elsif user.isInsuranceCompany? && user.stripe_financial_account_id.blank?
      treasury_account = Stripe::Treasury::FinancialAccount.create({
          supported_currencies: ['usd'],
          features: {
            intra_stripe_flows: {requested: true}, # For sending money to LF financial account
            inbound_transfers: {ach: {requested: true}}, # For transferring from IC bank account to IC financial account
          },
        },
        {stripe_account: user.stripe_account_id},
      )
    end
    user.save
  end

  before_create do |user|
    if user.organization_id == 0
      user.organization_id = nil
    end     
    if user.role.blank? && !user.organization.blank?
      if user.organization.isLawFirm?
        self.role = "Attorney"
      elsif user.organization.isInsuranceCompany?
        self.role = "Insurance Agent"
      end
    end
  end

  after_commit do |user|
    # If stripe data changed, verify data with stripe servers
  end

  def full_name
    if isOrganization?
      return business_name
    end
    full = ""
    if !first_name.blank?
      full += first_name
      if !last_name.blank?
        full += " #{last_name}"
      end
    elsif !last_name.blank?
      full += last_name
    end
    return full
  end

  def self.all_attorneys
    return User.where(:role => "Attorney").order(:first_name, :last_name, :organization_id)
  end

  def self.all_insurance_agents
    return User.where(:role => "Insurance Agent").order(:first_name, :last_name, :organization_id)
  end

  def self.all_law_firms
    return User.where(:role => "Law Firm").order(:first_name, :organization_id)
  end

  def self.all_insurance_companies
    return User.where(:role => "Insurance Company").order(:first_name, :organization_id)
  end

  def self.all_organizations
    return User.where(:role => "Insurance Company").or(User.where(:role => "Law Firm")).order(:first_name, :organization_id)
  end

  def isAttorney?
    return role == "Attorney"
  end

  def isInsuranceAgent?
    return role == "Insurance Agent"
  end

  def isLawFirm?
    return role == "Law Firm"
  end

  def isInsuranceCompany?
    return role == "Insurance Company"
  end
  
  def isOrganization?
    return role == "Law Firm" || role == "Insurance Company"
  end

  def isMember?
    return role == "Attorney" || role == "Insurance Agent"
  end

  def has_bank_account?
    return !bank_accounts.empty?
  end

  def payments
    if isLawFirm?
      return payments_in
    elsif isInsuranceCompany?
      return payments_out
    elsif isAttorney?
      return a_payments
    elsif isInsuranceAgent?
      return ia_payments
    end
  end

  def settlements
    if isAttorney?
      return a_settlements
    elsif isInsuranceAgent?
      return ia_settlements
    elsif isLawFirm?
      attorney_id_array = User.where(organization_id: id).pluck(:id)
      settlements = Settlement.where(attorney_id: attorney_id_array).all
    elsif isInsuranceCompany?
      agent_id_array = User.where(organization_id: id).pluck(:id)
      settlements = Settlement.where(insurance_agent_id: agent_id_array).all
    end
  end

  def default_bank_account
    return bank_accounts.default.first
  end
end
