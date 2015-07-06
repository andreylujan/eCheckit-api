Rails.application.routes.draw do

  resources :reasons
  apipie
  resources :contests
  match '/*path', to: 'application#cors_preflight_check', via: :options
  resources :feedbacks, only: [ :create ]
  resources :access_tokens, only: [ :create ]
  resources :workspaces, only: [ :show, :index ] do
    post :admins
    get :dashboard
    resources :zone_assignments, only: [ :index, :create, :update, :destroy ]
    resources :channels, only: [ :index, :create, :update, :destroy ]
    resources :reasons, only: [ :index, :create, :update, :destroy ]
    resources :contests, only: [ :index, :create, :update, :destroy, :show ]
  end

  resources :organizations, only: [ :show ] do
    resources :contest_phrases, only: [ :create, :index, :show, :destroy ]
  end
  resources :report_actions, only: [ :index, :create ]
  resources :reports, only: [ :show, :index, :create, :update ]
  resources :users, only: [ :create, :show, :update, :index ]
  resources :workspace_invitations, only: [ :show,  :create, :update ]
  resources :regions, only: [ :index ] do
    resources :communes, only: [ :index ]
  end

end
