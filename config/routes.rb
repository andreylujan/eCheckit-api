Rails.application.routes.draw do
  resources :subchannels
  resources :channels
  use_doorkeeper

  match '/*path', to: 'application#cors_preflight_check', via: :options
  resources :feedbacks, only: [ :create ]
  resources :access_tokens, only: [ :create ]
  resources :report_fields, only: [ :show, :index ]
  resources :report_field_types, only: [ :show, :index ]
  resources :contacts, only: [ :show, :index ]
  resources :venues, only: [ :show, :index ]
  resources :report_states, only: [ :show, :index ]
  resources :workspaces, only: [ :show, :index ] do
    post :admins
  end
  resources :pictures, only: [ :show, :index, :create ]
  resources :report_actions, only: [ :show, :index, :create ]
  resources :report_action_types, only: [ :show, :index ]
  resources :reports, only: [ :show, :index, :create, :update ]
  resources :users, only: [ :create, :show, :update, :index ]
  devise_for :users, skip: [:registrations, :confirmations], skip_helpers: true
  resources :organizations, only: [ :show, :index ]
  resources :workspace_invitations, only: [ :show, :index, :create, :update ]
end
