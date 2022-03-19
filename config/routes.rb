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
  get 'ds_test_page',                          to: 'pages#ds_test_page',                 as: 'ds_test_page'

  get 'release_forms',                        to: 'release_forms#index',                as: 'release_form_index'
  get 'release_forms/new',                    to: 'release_forms#new',                  as: 'release_form_new'
  get 'release_forms/:id',                    to: 'release_forms#show',                 as: 'release_form_show'
  get 'release_forms/edit/:id',               to: 'release_forms#edit',                 as: 'release_form_edit'
  post 'release_forms/new',                   to: 'release_forms#create',               as: 'release_form_create'
  patch 'release_forms/:id',                  to: 'release_forms#update',               as: 'release_form_update'
  delete 'release_forms/:id',                 to: 'release_forms#destroy',              as: 'release_form_delete'

  # Generated release form index is handled by the release_forms controller.
  get 'generated_release_forms/new',          to: 'generated_release_forms#new',        as: 'generated_release_form_new'
  # Generated release form showing is handled by the release_forms controller.
  get 'generated_release_forms/edit/:id',     to: 'generated_release_forms#edit',       as: 'generated_release_form_edit'
  post 'generated_release_forms/new',         to: 'generated_release_forms#create',     as: 'generated_release_form_create'
  patch 'generated_release_forms/:id',        to: 'generated_release_forms#update',     as: 'generated_release_form_update'
  # Generated release form destruction is also handled by the release_forms controller.
  
  post 'comment/:release_form_id',                         to: 'comments#create',                     as: 'comment_create'

end
