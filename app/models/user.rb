# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  login      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
end
