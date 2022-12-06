# == Schema Information
#
# Table name: log_books
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  public_id  :string
#
require 'rails_helper'

RSpec.describe LogBook, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
