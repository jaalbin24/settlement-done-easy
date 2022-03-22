# == Schema Information
#
# Table name: settlements
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  insurance_agent_id :integer
#  lawyer_id          :integer
#  release_form_id    :integer
#
# Indexes
#
#  index_settlements_on_insurance_agent_id  (insurance_agent_id)
#  index_settlements_on_lawyer_id           (lawyer_id)
#  index_settlements_on_release_form_id     (release_form_id)
#
# Foreign Keys
#
#  insurance_agent_id  (insurance_agent_id => users.id)
#  lawyer_id           (lawyer_id => users.id)
#  release_form_id     (release_form_id => release_forms.id)
#
class Settlement < ApplicationRecord
end
