# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  organization           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  stripe_account_id      :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, inclusion: {in: ["Insurance Agent", "Lawyer"]}
  validates :first_name, :last_name, :email, :encrypted_password, presence: true

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
    foreign_key: 'lawyer_id',
    inverse_of: :lawyer,
    dependent: :destroy
  )

  has_many(
    :ia_settlements,
    class_name: 'Settlement',
    foreign_key: 'insurance_agent_id',
    inverse_of: :insurance_agent,
    dependent: :destroy
  )

  after_create do
    if self.isLawyer? && self.stripe_account_id == nil
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

  def self.all_lawyers
    return User.where(:role => "Lawyer").order(:first_name, :last_name, :organization)
  end

  def self.all_insurance_agents
    return User.where(:role => "Insurance Agent").order(:first_name, :last_name, :organization)
  end

  def isLawyer?
    return role == "Lawyer"
  end

  def isInsuranceAgent?
    return role == "Insurance Agent"
  end

  def settlements
    if isLawyer?
      return l_settlements
    elsif isInsuranceAgent?
      return ia_settlements
    end
  end

  def opposite_role
    if isLawyer?
      return :insurance_agent
    elsif isInsuranceAgent?
      return :lawyer
    else
      return
    end
  end
end
