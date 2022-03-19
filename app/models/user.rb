# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
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

  # validates :role, inclusion: {in: ["Insurance Agent", "Lawyer"]}

has_many(
  :lawyer_owned_release_forms,
  class_name: 'ReleaseForm',
  foreign_key: 'lawyer_id',
  inverse_of: :lawyer
)

has_many(
  :insurance_agent_owned_release_forms,
  class_name: 'ReleaseForm',
  foreign_key: 'insurance_agent_id',
  inverse_of: :insurance_agent
)

end
