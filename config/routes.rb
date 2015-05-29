Rails.application.routes.draw do

  match '/*path', to: 'application#cors_preflight_check', via: :options
  resources :feedbacks, only: [ :create ]
  resources :access_tokens, only: [ :create ]
  resources :workspaces, only: [ :show, :index ] do
    post :admins
  end

  resources :report_actions, only: [ :index, :create ]
  resources :reports, only: [ :show, :index, :create, :update ]
  resources :users, only: [ :create, :show, :update, :index ]
  resources :workspace_invitations, only: [ :show,  :create, :update ]
  resources :regions, only: [ :index ]
end
