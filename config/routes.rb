# == Route Map
#

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'user/registrations'}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#root"

  get 'what_type_of_user',                      to: 'pages#user_type_select',             as: 'user_type_select'
  get 'generate_or_upload',                     to: 'pages#generate_or_upload',           as: 'generate_or_upload'
  get 'testing',                                to: 'pages#testing',                      as: 'testing'    

  get 'bank_account/new',                       to: 'bank_accounts#new',                   as: 'bank_account_new'
  
  get 'documents/edit/:id',                     to: 'documents#edit',                     as: 'document_edit'
  get 'documents/:id/ready_to_send',            to: 'documents#ready_to_send',            as: 'document_ready_to_send'
  post 'documents/:id/approve',                 to: 'documents#approve',                  as: 'document_approve'
  post 'documents/:id/reject',                  to: 'documents#reject',                   as: 'document_reject'
  get 'document/:id/get_e_signature',           to: 'documents#get_e_signature',          as: 'document_get_e_signature'
  patch 'documents/:id/send_ds_signature_request',  to: 'documents#send_ds_signature_request', as: 'document_send_ds_signature_request'
  get 'documents/:id/get_ds_envelope_status',   to: 'documents#get_ds_envelope_status',   as: 'document_get_ds_envelope_status'  
  get 'documents/:id',                          to: 'documents#show',                     as: 'document_show'
  get 'settlements/:id/documents',              to: 'documents#index',                    as: 'document_index'


  post 'settlements/:id/documents/new',         to: 'documents#create',                   as: 'document_create'
  get 'settlements/:id/documents/new',          to: 'documents#new',                      as: 'document_new'
  get 'settlements/:id/generate_document',      to: 'settlements#generate_document',      as: 'settlement_generate_document'
  patch 'documents/:id',                        to: 'documents#update',                   as: 'document_update'
  delete 'documents/:id',                       to: 'documents#destroy',                  as: 'document_delete'
  
  post 'comment/:document_id',                  to: 'comments#create',                    as: 'comment_create'

  get 'settlements/new',                              to: 'settlements#new',                    as: 'settlement_new'
  get 'settlements/need_index/:stage/:status',        to: 'settlements#need_index',             as: 'settlement_need_index'
  get 'settlements/:id',                              to: 'settlements#show',                   as: 'settlement_show'
  get 'settlements/:id/review_document',              to: 'settlements#review_document',        as: 'settlement_review_document'
  get 'settlements/:id/review_signed_document',       to: 'settlements#review_signed_document', as: 'settlement_review_signed_document'

  get 'settlements/:id/get_client_signature',         to: 'settlements#get_client_signature',   as: 'settlement_get_client_signature'
  get 'settlements/:id/start_stripe_session',         to: 'settlements#start_stripe_session',   as: 'settlement_start_stripe_session'
  get 'settlements/:id/payment_success',              to: 'settlements#payment_success',        as: 'settlement_payment_success'
  get 'settlements/:id/complete',                     to: 'settlements#complete',               as: 'settlement_complete'
  post 'settlements',                                 to: 'settlements#create',                 as: 'settlement_create'
  patch 'settlements/:id',                            to: 'settlements#update',                 as: 'settlement_update'
  patch 'settlements/:id/send_ds_signature_request',  to: 'settlements#send_ds_signature_request', as: 'settlement_send_ds_signature_request'
  delete 'settlement/:id',                            to: 'settlements#destroy',                as: 'settlement_destroy'

  get 'stripe_onboard_account_link',                  to: 'stripe#onboard_account_link',        as: 'stripe_onboard_account_link'
  get 'stripe_handle_return_from_onboard',            to: 'stripe#handle_return_from_onboard',  as: 'stripe_handle_return_from_onboard'
  get 'stripe_login_link',                            to: 'stripe#login_link',                  as: 'stripe_login_link'
  get 'stripe_initiate_settlement_payment/:id',       to: 'stripe#initiate_settlement_payment', as: 'stripe_initiate_settlement_payment'
  get 'stripe_get_payment_status/:id',                to: 'stripe#get_payment_status',          as: 'stripe_get_payment_status'
  get 'stripe_add_payment_method',                    to: 'stripe#add_payment_method',          as: 'stripe_add_payment_method'
  get 'stripe_client_secret',                         to: 'stripe#client_secret',               as: 'stripe_client_secret'
  get 'stripe_dashboard',                             to: 'stripe#dashboard',                   as: 'stripe_dashboard'

  get 'organizations/join',                           to: 'organization_users#join',                  as: 'organization_join'
  get 'organizations/:org_id/members/new',            to: 'organization_users#new_member',            as: 'organization_new_member'
  get 'organizations/:org_id/settlements',            to: 'organization_users#settlements_index',     as: 'organization_settlements_index'
  get 'organizations/:org_id/members',                to: 'organization_users#members_index',         as: 'organization_members_index'
  get 'organizations/:org_id/members/:mem_id',        to: 'organization_users#show_member',           as: 'organization_show_member'
  delete 'organizations/:org_id/members/:mem_id',     to: 'organization_users#remove_member',         as: 'organization_remove_member'
  patch 'organizations/:org_id/members/:mem_id',      to: 'organization_users#add_member',            as: 'organization_add_member'
  post 'organizations/:org_id/members/',              to: 'organization_users#create_member',         as: 'organization_create_member'

  post 'webhook/stripe',                              to: 'stripe#handle_event',                      as: 'stripe_webhook_handle_event'
  


end
