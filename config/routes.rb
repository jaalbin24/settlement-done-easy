# == Route Map
#

Rails.application.routes.draw do
  devise_for :insurance_agents
  devise_for :counselors  
  devise_for :users, controllers: { registrations: 'user/registrations'}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  get 'home',                     to: 'pages#home',             as: 'home'
  get 'what_type_of_user',        to: 'pages#user_type_select', as: 'user_type_select'

  get 'release_forms',            to: 'release_forms#index',    as: 'release_form_index'
  get 'release_forms/new',        to: 'release_forms#new',      as: 'release_form_new'
  get 'release_forms/:id',        to: 'release_forms#show',     as: 'release_form_show'
  get 'release_forms/edit/:id',   to: 'release_forms#edit',     as: 'release_form_edit'
  post 'release_forms',           to: 'release_forms#create',   as: 'release_form_create'
  patch 'release_forms/:id',      to: 'release_forms#update',   as: 'release_form_update'
  delete 'release_forms/:id',     to: 'release_forms#destroy',  as: 'release_form_delete'

end
