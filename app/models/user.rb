# == Schema Information
#
# Table name: users
#
#  id                       :bigint           not null, primary key
#  business_name            :string
#  current_sign_in_at       :datetime
#  current_sign_in_ip       :string
#  email                    :string           default(""), not null
#  encrypted_password       :string           default(""), not null
#  first_name               :string
#  last_name                :string
#  last_sign_in_at          :datetime
#  last_sign_in_ip          :string
#  remember_created_at      :datetime
#  reset_password_sent_at   :datetime
#  reset_password_token     :string
#  role                     :string
#  sign_in_count            :integer          default(0), not null
#  stripe_account_onboarded :boolean          default(FALSE), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  organization_id          :bigint
#  stripe_account_id        :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_organization_id       (organization_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => users.id)
#
class User < ApplicationRecord
  include EnglishLanguageSupport
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :role, inclusion: {in: ["Insurance Agent", "Attorney", "Law Firm", "Insurance Company", "Dummy"]}
  validates :email, :role, :encrypted_password, presence: true
  validates :first_name, :last_name, presence: {unless: :isOrganization?}
  validates :first_name, :last_name, absence: {if: :isOrganization?}
  validates :business_name, presence: {if: :isOrganization?}
  validates :business_name, absence: {unless: :isOrganization?}

  validate :name_has_valid_characters
  def name_has_valid_characters
    if business_name != nil && isOrganization? && !business_name.tr(" &-", "").match?(/\A[a-zA-Z0-9'-]*\z/)
      errors.add(:business_name, "can only contain letters, numbers, ampersands (&), and hyphens (-)")
    elsif !isOrganization?
      if first_name != nil && !first_name.tr(" -", "").match?(/\A[a-zA-Z'-]*\z/)
        errors.add(:first_name, "can only contain letters and hyphens (-)")
      end
      if last_name != nil && !last_name.tr(" -", "").match?(/\A[a-zA-Z'-]*\z/)
        errors.add(:last_name, "can only contain letters and hyphens (-)")
      end
    end
  end

  # Organization-type users cannot belong to an organization.
  validates :organization, absence: {if: :isOrganization?, message: "must be nil for organization-type users, not '%{value}'"}
  
  # Stripe data constraints.
  validates :stripe_account_id, absence: {unless: :isOrganization?, message: "must be nil for non-organization-type users, not '%{value}'"}
  validates :stripe_account_onboarded, inclusion: {in: [false], unless: :isLawFirm?, message: "cannot be true if user is not a Law Firm"}
  
  # Member-type users cannot belong to another member-type user.
  validate :member_cannot_belong_to_member
  def member_cannot_belong_to_member
    if organization != nil
      errors.add(:organization, "must be an organization-type user, not '#{indefinite_articleize(organization.role)}'") unless organization.isOrganization?
    end
  end

  validate :role_must_match_organization_type
  def role_must_match_organization_type
    if organization != nil && role != nil
      errors.add(:organization, "member must have appropriate user role. The role of '#{role}' is invalid for members of the organization '#{organization.role}'") unless (organization.isLawFirm? && isAttorney?) || (organization.isInsuranceCompany? && isInsuranceAgent?)
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
    :l_settlements,
    class_name: 'Settlement',
    foreign_key: 'attorney_id',
    inverse_of: :attorney,
    dependent: :destroy
  )

  has_many(
    :ia_settlements,
    class_name: 'Settlement',
    foreign_key: 'insurance_agent_id',
    inverse_of: :insurance_agent,
    dependent: :destroy
  )

  belongs_to(
    :organization,
    class_name: "User",
    foreign_key: "organization_id",
    inverse_of: :organization_members,
    optional: true
  )

  has_many(
    :organization_members,
    class_name: "User",
    foreign_key: "organization_id",
    inverse_of: :organization
  )

  after_create do
    # if self.isLawFirm? && self.stripe_account_id == nil
    #   account = Stripe::Account.create({
    #     type: "express",
    #     country: "US",
    #     email: self.email,
    #     capabilities: {
    #       us_bank_account_ach_payments: {requested: true},
    #       card_payments: {requested: true},
    #       transfers: {requested: true},
    #     },
    #     business_type: "company",
    #     business_profile: {url: "http://settlementdoneeasy.com/"}
    #   })
    #   self.stripe_account_id = account.id
    #   self.save
    # end
  end

  before_create do
    if self.organization_id == 0
      self.organization_id = nil
    end
  end

  def full_name
    if isOrganization?
      return business_name
    end
    full = ""
    if first_name != nil
      full += first_name
      if last_name != nil
        full += " #{last_name}"
      end
    elsif last_name != nil
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

  def settlements
    if isAttorney?
      return l_settlements
    elsif isInsuranceAgent?
      return ia_settlements
    elsif isOrganization?
      settlements = Array.new
      organization_members.each do |u|
        settlements += u.settlements
      end
      return settlements
    end
  end
end
