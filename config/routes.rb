Rails.application.routes.draw do

  resources :contact_doms
  resources :works_doms
  resources :clients_doms
  resources :works
  resources :clients

  apipie
  match '/*path', to: 'application#cors_preflight_check', via: :options

  resources :feedbacks, only: [ :create ]
  resources :access_tokens, only: [ :create ]
  resources :workspaces, only: [ :show, :index ] do
    post :admins
    get :dashboard
    get :excel
    resources :reports, only: [ :index ]
    resources :zone_assignments, only: [ :index, :create, :update, :destroy ]
    resources :channels, only: [ :index, :create, :update, :destroy ]
    resources :reasons, only: [ :index, :create, :update, :destroy ]
    resources :contests, only: [ :index, :create, :update, :destroy, :show ]
    delete 'users/:id', to: 'workspaces#delete_user'
  end

  resources :organizations, only: [ :show ] do
    resources :contest_phrases, only: [ :create, :index, :show, :destroy, :update ]
  end

  resources :report_actions, only: [ :index, :create ]
  resources :reports, only: [ :show, :index, :create, :update ]

  resources :users, only: [ :create, :show, :update, :index ] do
    collection do 
      post :request_validation_token
      post :change_password
    end
  end

  resources :devices, only: [ :create, :update, :destroy ]

  resources :workspace_invitations, only: [ :show,  :create, :update ] 

  delete '/workspace_invitations', to: 'workspace_invitations#destroy'

  resources :regions, only: [ :index ] do
    resources :communes, only: [ :index ]
  end

end
