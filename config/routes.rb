# == Route Map
#

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'user/registrations'}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "settlements#dashboard"

  get 'what_type_of_user',                      to: 'pages#user_type_select',             as: 'user_type_select'
  get 'generate_or_upload',                     to: 'pages#generate_or_upload',           as: 'generate_or_upload'
  get 'testing',                                to: 'pages#testing',                      as: 'testing'    
  get ':settlement_id/release_forms/new',       to: 'release_forms#new',                  as: 'release_form_new'
  get 'release_forms/:id',                      to: 'release_forms#show',                 as: 'release_form_show'
  get 'release_forms/edit/:id',                 to: 'release_forms#edit',                 as: 'release_form_edit'
  get 'release_forms/:id/ready_to_send',        to: 'release_forms#ready_to_send',        as: 'release_form_ready_to_send'
  post 'release_forms/approve/:id',             to: 'release_forms#approve_form',         as: 'approve_form'

  post ':settlement_id/release_forms/new',      to: 'release_forms#create',               as: 'release_form_create'
  patch 'release_forms/:id',                    to: 'release_forms#update',               as: 'release_form_update'
  delete 'release_forms/:id',                   to: 'release_forms#destroy',              as: 'release_form_delete'


  # Generated release form index is handled by the release_forms controller.
  get 'generated_release_forms/new',            to: 'generated_release_forms#new',        as: 'generated_release_form_new'
  # Generated release form showing is handled by the release_forms controller.
  get 'generated_release_forms/edit/:id',       to: 'generated_release_forms#edit',       as: 'generated_release_form_edit'
  post 'generated_release_forms/new',           to: 'generated_release_forms#create',     as: 'generated_release_form_create'
  patch 'generated_release_forms/:id',          to: 'generated_release_forms#update',     as: 'generated_release_form_update'
  # Generated release form destruction is also handled by the release_forms controller.
  
  post 'comment/:release_form_id',              to: 'comments#create',                    as: 'comment_create'

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
