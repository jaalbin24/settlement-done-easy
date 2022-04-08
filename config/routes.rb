# == Route Map
#

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'user/registrations'}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "settlements#dashboard"

  get 'what_type_of_user',                      to: 'pages#user_type_select',             as: 'user_type_select'
  get 'generate_or_upload',                     to: 'pages#generate_or_upload',           as: 'generate_or_upload'
  get 'testing',                                to: 'pages#testing',                      as: 'testing'    
  get ':settlement_id/documents/new',       to: 'documents#new',                  as: 'document_new'
  get 'documents/:id',                      to: 'documents#show',                 as: 'document_show'
  get 'documents/edit/:id',                 to: 'documents#edit',                 as: 'document_edit'
  get 'documents/:id/ready_to_send',        to: 'documents#ready_to_send',        as: 'document_ready_to_send'
  post 'documents/approve/:id',             to: 'documents#approve_form',         as: 'approve_form'

  post ':settlement_id/documents/new',      to: 'documents#create',               as: 'document_create'
  patch 'documents/:id',                    to: 'documents#update',               as: 'document_update'
  delete 'documents/:id',                   to: 'documents#destroy',              as: 'document_delete'


  # Generated document index is handled by the documents controller.
  get 'generated_documents/new',            to: 'generated_documents#new',        as: 'generated_document_new'
  # Generated document showing is handled by the documents controller.
  get 'generated_documents/edit/:id',       to: 'generated_documents#edit',       as: 'generated_document_edit'
  post 'generated_documents/new',           to: 'generated_documents#create',     as: 'generated_document_create'
  patch 'generated_documents/:id',          to: 'generated_documents#update',     as: 'generated_document_update'
  # Generated document destruction is also handled by the documents controller.
  
  post 'comment/:document_id',              to: 'comments#create',                    as: 'comment_create'

  get 'dashboard',                                    to: 'settlements#dashboard',              as: 'settlement_dashboard'
  get 'settlements/new',                              to: 'settlements#new',                    as: 'settlement_new'
  get 'settlements/:id/approve_stage1_document',      to: 'settlements#approve_stage1_document',as: 'settlement_approve_stage1_document'
  get 'settlements/:id/reject_stage1_document',       to: 'settlements#reject_stage1_document', as: 'settlement_reject_stage1_document'
  get 'settlements/:id/approve_stage2_document',      to: 'settlements#approve_stage2_document',as: 'settlement_approve_stage2_document'
  get 'settlements/:id/reject_stage2_document',       to: 'settlements#reject_stage2_document', as: 'settlement_reject_stage2_document'
  get 'settlements/need_index/:stage/:status',        to: 'settlements#need_index',             as: 'settlement_need_index'
  get 'settlements/:id',                              to: 'settlements#show',                   as: 'settlement_show'
  get 'settlements/:id/review_document',              to: 'settlements#review_document',        as: 'settlement_review_document'
  get 'settlements/:id/review_final_document',        to: 'settlements#review_final_document',  as: 'settlement_review_final_document'

  get 'settlements/:id/get_client_signature',         to: 'settlements#get_client_signature',   as: 'settlement_get_client_signature'
  get 'settlements/:id/start_stripe_session',         to: 'settlements#start_stripe_session',   as: 'settlement_start_stripe_session'
  get 'settlements/:id/get_ds_envelope_status',       to: 'settlements#get_ds_envelope_status', as: 'settlement_get_ds_envelope_status'
  get 'settlements/:id/payment_success',              to: 'settlements#payment_success',        as: 'settlement_payment_success'
  get 'settlements/:id/complete',                     to: 'settlements#complete',               as: 'settlement_complete'
  post 'settlements',                                 to: 'settlements#create',                 as: 'settlement_create'
  patch 'settlements/:id',                            to: 'settlements#update',                 as: 'settlement_update'
  patch 'settlements/:id/send_ds_signature_request',  to: 'settlements#send_ds_signature_request', as: 'settlement_send_ds_signature_request'
  delete 'settlement/:id',                            to: 'settlements#destroy',                as: 'settlement_destroy'

  get 'stripe_onboard_account_link',                  to: 'stripe#onboard_account_link',        as: 'stripe_onboard_account_link'
  get 'stripe_handle_return_from_onboard',            to: 'stripe#handle_return_from_onboard',  as: 'stripe_handle_return_from_onboard'
  get 'stripe_login_link',                            to: 'stripe#login_link',                  as: 'stripe_login_link'
  get 'stripe_settlement_checkout_session/:id',       to: 'stripe#settlement_checkout_session', as: 'stripe_settlement_checkout_session'
  get 'stripe_get_payment_status/:id',                to: 'stripe#get_payment_status',          as: 'stripe_get_payment_status'
end
