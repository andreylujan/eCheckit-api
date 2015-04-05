Rails.application.routes.draw do

  use_doorkeeper
  use_doorkeeper
  resources :report_fields, only: [ :show, :index ]
  resources :report_field_types, only: [ :show, :index ]
  resources :contacts, only: [ :show, :index ]
  resources :venues, only: [ :show, :index ]
  resources :report_states, only: [ :show, :index ]
  resources :report_types, only: [ :show, :index ]
  resources :pictures, only: [ :show, :index, :create ]
  resources :actions, only: [ :show, :index ]
  resources :action_types, only: [ :show, :index ]
  resources :reports, only: [ :show, :index, :create, :update ]
  resources :users, only: [ :create, :show, :update ]
  devise_for :users, skip: [:registrations, :confirmations], skip_helpers: true
  resources :organizations, only: [ :show, :index ]
end
