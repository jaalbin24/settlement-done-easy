# == Route Map
#

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'user/registrations'}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  get 'home',                                 to: 'pages#home',                         as: 'home'
  get 'what_type_of_user',                    to: 'pages#user_type_select',             as: 'user_type_select'
  get 'generate_or_upload',                   to: 'pages#generate_or_upload',           as: 'generate_or_upload'    
  get 'approve_or_reject/:id',                to: 'pages#approve_or_reject',            as: 'approve_or_reject'

  get 'release_forms',                        to: 'release_forms#index',                as: 'release_form_index'
  get ':settlement_id/release_forms/new',     to: 'release_forms#new',                  as: 'release_form_new'
  get 'release_forms/:id',                    to: 'release_forms#show',                 as: 'release_form_show'
  get 'release_forms/edit/:id',               to: 'release_forms#edit',                 as: 'release_form_edit'
  get 'release_forms/:id/ready_to_send',      to: 'release_forms#ready_to_send',        as: 'release_form_ready_to_send'
  post 'release_forms/approve/:id',           to: 'release_forms#approve_form',         as: 'approve_form'

  post ':settlement_id/release_forms/new',    to: 'release_forms#create',               as: 'release_form_create'
  patch 'release_forms/:id',                  to: 'release_forms#update',               as: 'release_form_update'
  patch 'release_forms/:id/send_to_client',   to: 'release_forms#send_to_client',       as: 'release_form_send_to_client'
  delete 'release_forms/:id',                 to: 'release_forms#destroy',              as: 'release_form_delete'


  # Generated release form index is handled by the release_forms controller.
  get 'generated_release_forms/new',          to: 'generated_release_forms#new',        as: 'generated_release_form_new'
  # Generated release form showing is handled by the release_forms controller.
  get 'generated_release_forms/edit/:id',     to: 'generated_release_forms#edit',       as: 'generated_release_form_edit'
  post 'generated_release_forms/new',         to: 'generated_release_forms#create',     as: 'generated_release_form_create'
  patch 'generated_release_forms/:id',        to: 'generated_release_forms#update',     as: 'generated_release_form_update'
  # Generated release form destruction is also handled by the release_forms controller.
  
  post 'comment/:release_form_id',            to: 'comments#create',                    as: 'comment_create'

  get 'settlements/new',                      to: 'settlements#new',                    as: 'settlement_new'
  get 'settlements/:id',                      to: 'settlements#show',                   as: 'settlement_show'
  post 'settlements',                         to: 'settlements#create',                 as: 'settlement_create'
  patch 'settlements/:id',                    to: 'settlements#update',                 as: 'settlement_update'
  get 'settlements/start_with_who',           to: 'settlements#start_with_who',         as: 'settlement_start_with_who'
  delete 'settlement/:id',                    to: 'settlements#destroy',                as: 'settlement_destroy'

  post 'settlement_partner_selected',         to: 'settlements#partner_selected',       as: 'settlement_partner_selected'


end
