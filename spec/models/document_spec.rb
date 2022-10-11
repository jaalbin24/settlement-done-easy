# == Schema Information
#
# Table name: documents
#
#  id              :bigint           not null, primary key
#  auto_generated  :boolean          default(FALSE), not null
#  needs_signature :boolean          default(FALSE), not null
#  nickname        :string
#  signed          :boolean          default(FALSE), not null
#  status          :string           default("Waiting for review"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  added_by_id     :bigint
#  ds_envelope_id  :string
#  log_book_id     :bigint
#  public_id       :string
#  settlement_id   :bigint
#
# Indexes
#
#  index_documents_on_added_by_id    (added_by_id)
#  index_documents_on_log_book_id    (log_book_id)
#  index_documents_on_settlement_id  (settlement_id)
#
# Foreign Keys
#
#  fk_rails_...  (added_by_id => users.id)
#  fk_rails_...  (log_book_id => log_books.id)
#  fk_rails_...  (settlement_id => settlements.id)
#
require 'rails_helper'

RSpec.describe "Documents", type: :model do

    describe "update_status_attribute method" do
        before(:each) do
            @document = create(:document, :from_the_ground_up)
        end
        it "changes the status to 'Approved' if all attached document reviews have a verdict of 'Approved'" do
            @document.reviews.update_all(verdict: "Approved")
            @document.update_status_attribute
            expect(@document.status).to eq("Approved")
        end
        it "changes the status to 'Rejected' if any attached document reviews have a verdict of 'Rejected'" do
            @document.reviews.not_by(@document.added_by).update(verdict: "Rejected")
            @document.update_status_attribute
            expect(@document.status).to eq("Rejected")
        end
        it "changes the status to 'Waiting for Review' if any attached document reviews have a verdict of 'Waiting' and none have a verdict of 'Rejected'" do
            @document.reviews.first.update(verdict: "Waiting")
            @document.update_status_attribute
            expect(@document.status).to eq("Waiting for review")
        end
        it "must not save the document model" do
            @document = build(:document, :from_the_ground_up)
            expect(@document.persisted?).to be_falsey
            @document.update_status_attribute
            expect(@document.persisted?).to be_falsey
        end
    end
end
