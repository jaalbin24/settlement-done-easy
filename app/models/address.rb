# == Schema Information
#
# Table name: addresses
#
#  id          :bigint           not null, primary key
#  city        :string
#  country     :string
#  line1       :string
#  line2       :string
#  postal_code :string
#  state       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  public_id   :string
#
class Address < ApplicationRecord


    def to_s
        [[[line1, line2].join(" "), [city, state].join(", ")].join(", "), country, postal_code].join(" ")
    end
end
