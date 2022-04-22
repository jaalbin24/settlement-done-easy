# == Schema Information
#
# Table name: users
#
#  id                       :bigint           not null, primary key
#  email                    :string           default(""), not null
#  encrypted_password       :string           default(""), not null
#  first_name               :string
#  last_name                :string
#  remember_created_at      :datetime
#  reset_password_sent_at   :datetime
#  reset_password_token     :string
#  role                     :string
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
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, inclusion: {in: ["Insurance Agent", "Attorney", "Law Firm", "Insurance Company"]}
  validates :first_name, :email, :encrypted_password, presence: true
  # validates :organization_id, absence: {if: :isorganization?, message: "organization must be nil. It is currently #{self.organization_id}"}


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

  has_one(
    :organization,
    class_name: "User",
    foreign_key: "organization_id",
    inverse_of: :organization_members
  )

  has_many(
    :organization_members,
    class_name: "User",
    foreign_key: "organization_id",
    inverse_of: :organization
  )

  after_create do
    if self.isLawFirm? && self.stripe_account_id == nil
      account = Stripe::Account.create({
        type: "express",
        country: "US",
        email: self.email,
        capabilities: {
          us_bank_account_ach_payments: {requested: true},
          card_payments: {requested: true},
          transfers: {requested: true},
        },
        business_type: "company",
        business_profile: {url: "http://settlementdoneeasy.com/"}
      })
      self.stripe_account_id = account.id
      self.save
    end
  end

  def full_name
    return "#{first_name} #{last_name}"
  end

  def self.all_attorneys
    return User.where(:role => "Attorney").order(:first_name, :last_name, :organization)
  end

  def self.all_insurance_agents
    return User.where(:role => "Insurance Agent").order(:first_name, :last_name, :organization)
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
