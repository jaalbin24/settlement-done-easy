require 'sidekiq/web'

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  devise_for :users, controllers: { registrations: 'user/registrations', sessions: 'user/sessions'}
  devise_scope :user do
    put 'user/validate',                        to: 'user/registrations#validate_user_details'
    get 'user/changeemail',                     to: 'user/registrations#change_email',        as: 'change_email'
    get 'user/changepassword',                  to: 'user/registrations#change_password',     as: 'change_password'
    get 'user/changephonenumber',               to: 'user/registrations#change_phone_number', as: 'change_phone_number'
  end

  mount Sidekiq::Web => '/sidekiq'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#root"

  get 'what_type_of_user',                      to: 'pages#user_type_select',             as: 'user_type_select'
  get 'under_construction',                     to: 'pages#under_construction',           as: 'under_construction'
  
  get 'documents/:id/ready_to_send',            to: 'documents#ready_to_send',            as: 'document_ready_to_send'
  post 'documents/:id/approve',                 to: 'document_reviews#approve',           as: 'document_approve'
  post 'documents/:id/reject',                  to: 'document_reviews#reject',            as: 'document_reject'
  post 'documents/:id/unreject',                to: 'document_reviews#unreject',          as: 'document_unreject'
  get 'documents/:id',                          to: 'documents#show',                     as: 'document_show'
  get 'documents/html/:public_id',              to: 'documents#show_inline_html',         as: 'inline_document'


  post 'settlements/:id/documents/new',         to: 'documents#create',                   as: 'document_create'
  get 'settlements/:id/documents/new',          to: 'documents#new',                      as: 'document_new'
  post 'settlements/:id/generate_document',     to: 'settlements#generate_document',     as: 'settlement_generate_document'
  post 'documents/:id',                        to: 'documents#update',                   as: 'document_update'
  delete 'documents/:id',                       to: 'documents#destroy',                  as: 'document_delete'
  

  post 'settlements/search',                          to: 'search_settlements#search',          as: 'settlement_search'
  get 'settlements/new',                              to: 'settlements#new',                    as: 'settlement_new'
  get 'settlements/completed',                        to: 'settlements#completed_index',        as: 'settlement_completed_index'
  get 'settlements/need_index/:stage/:status',        to: 'settlements#need_index',             as: 'settlement_need_index'
  get 'settlements/:id',                              to: 'settlements#show',                   as: 'settlement_show'
  get 'settlements/:id/review_document',              to: 'settlements#review_document',        as: 'settlement_review_document'

  get 'settlements/:id/start_stripe_session',         to: 'settlements#start_stripe_session',   as: 'settlement_start_stripe_session'
  get 'settlements/:id/payment_success',              to: 'settlements#payment_success',        as: 'settlement_payment_success'
  get 'settlements/:id/complete',                     to: 'settlements#complete',               as: 'settlement_complete'
  post 'settlements',                                 to: 'settlements#create',                 as: 'settlement_create'
  patch 'settlements/:id',                            to: 'settlements#update',                 as: 'settlement_update'

  delete 'settlement/:id',                            to: 'settlements#destroy',                as: 'settlement_destroy'

  get 'stripe_onboard_account_link',                  to: 'stripe#onboard_account_link',        as: 'stripe_onboard_account_link'
  get 'stripe_handle_return_from_onboard',            to: 'stripe#handle_return_from_onboard',  as: 'stripe_handle_return_from_onboard'
  get 'stripe_login_link',                            to: 'stripe#login_link',                  as: 'stripe_login_link'
  get 'stripe_get_payment_status/:id',                to: 'stripe#get_payment_status',          as: 'stripe_get_payment_status'
  get 'stripe_add_payment_method',                    to: 'stripe#add_payment_method',          as: 'stripe_add_payment_method'
  get 'stripe_dashboard',                             to: 'stripe#dashboard',                   as: 'stripe_dashboard'

  get 'members/new',                                  to: 'organization_users#new_member',            as: 'member_new'
  get 'organizations/settlements',                    to: 'organization_users#settlements_index',     as: 'organization_settlements_index'
  get 'organizations/members',                        to: 'organization_users#members_index',         as: 'organization_members_index'
  get 'organizations/:org_id/members/:mem_id',        to: 'organization_users#show_member',           as: 'organization_show_member'
  delete 'organizations/:org_id/members/:mem_id',     to: 'organization_users#remove_member',         as: 'organization_remove_member'
  patch 'organizations/:org_id/members/:mem_id',      to: 'organization_users#add_member',            as: 'organization_add_member'
  post 'organizations/:org_id/members/',              to: 'organization_users#create_member',         as: 'organization_create_member'

  post 'webhook/stripe',                              to: 'stripe#handle_event',                      as: 'stripe_webhook_handle_event'

  get 'payments',                                     to: 'payments#index',                           as: 'payment_index'
  get 'payments/:id',                                 to: 'payments#show',                            as: 'payment_show'
  patch 'payments/:id',                               to: 'payments#update',                          as: 'payment_update'
  post 'payments/:id/sync',                           to: 'payments#sync_with_stripe',                as: 'payment_sync_with_stripe'
  post 'payments/:id/execute',                        to: 'payments#execute',                         as: 'payment_execute'

  post 'settlement/:id/payment_request',              to: 'payment_requests#create',                  as: 'payment_request_create'
  post 'payment_request/:id/accept',                  to: 'payment_requests#accept',                  as: 'payment_request_accept'
  post 'payment_request/:id/deny',                    to: 'payment_requests#deny',                    as: 'payment_request_deny'

  post 'user_settings',                               to: 'user_settings#update',                     as: 'user_settings_update'
  get 'settings',                                     to: 'pages#settings',                           as: 'settings'
  get 'settings/account',                             to: 'user_settings#account',                    as: 'account_settings'
  get 'settings/profile',                             to: 'user_settings#profile',                    as: 'profile_settings'
  get 'settings/wallet',                              to: 'user_settings#wallet',                     as: 'wallet_settings'
  put 'settings/profile',                             to: 'user_profile_settings#update',             as: 'user_profile_settings_update'
  

  post 'settlement_attribute_reviews/:id/update',     to: 'settlement_attributes_reviews#update',     as: 'settlement_attributes_review_update'
  
  get 'requirements',                                 to: 'pages#requirements',                       as: 'requirements'

  get 'user/profile/:public_id',                      to: 'user_profile#show',                        as: 'user_profile_show'
  get 'user/profile/:public_id/edit',                 to: 'user_profile#edit',                        as: 'user_profile_edit'
  put 'user/profile/:public_id',                      to: 'user_profile#update',                      as: 'user_profile_update'

  get 'cancel_changes',                               to: 'pages#cancel_changes',                     as: 'cancel_changes'

  get 'payment_method/new',                           to: 'bank_accounts#new',                        as: 'payment_method_new'
  get 'payment_method/new/bank_account',              to: 'bank_accounts#new',                        as: 'bank_account_new'
  get 'payment_method/new/card',                      to: 'cards#new',                                as: 'card_new'
  post 'payment_method/card',                         to: 'cards#create',                             as: 'card_create'

  patch 'bank_accounts/:public_id',                   to: 'bank_accounts#update',                     as: 'bank_account_update'
  get 'card/new/secret',                              to: 'cards#secret',                             as: 'new_card_secret'
  get 'bank_account/new/secret',                      to: 'bank_accounts#secret',                     as: 'new_bank_account_secret'
  get 'bank_account/new/after',                       to: 'bank_accounts#after_create',               as: 'bank_account_after_create'
  delete 'bank_account/:public_id',                   to: 'bank_accounts#delete',                     as: 'bank_account_delete'



  post 'signatures',                                  to: 'signatures#create',                        as: 'signature_create'

end
