FactoryBot.define do
    factory :payment_request do
        association :requester, factory: :attorney
        association :accepter, factory: :adjuster
        settlement
        status {"Requested"}
    end
end