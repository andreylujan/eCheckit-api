Rails.application.routes.draw do

  match '/*path', to: 'application#cors_preflight_check', via: :options
  
  current_api_routes = lambda do

    

    resources :feedbacks, only: [ :create ]
    resources :access_tokens, only: [ :create ]
    resources :workspaces, only: [ :show, :index ] do
      post :admins
      get :dashboard
      get :excel
      resources :clients, only: [ :index ]
      resources :constructions, only: [ :index ]
      resources :contacts, only: [ :index ]
      resources :reports, only: [ :index ]
      resources :zone_assignments, only: [ :index, :create, :update, :destroy ]
      resources :channels, only: [ :index, :create, :update, :destroy ]
      resources :reasons, only: [ :index, :create, :update, :destroy ]
      resources :contests, only: [ :index, :create, :update, :destroy, :show ]
      resources :report_field_types, only: [ :index, :show ]
      delete 'users/:id', to: 'workspaces#delete_user'
    end

    resources :organizations, only: [ :show ] do
      resources :contest_phrases, only: [ :create, :index, :show, :destroy, :update ]
    end

    resources :report_actions, only: [ :index, :create ]
    resources :reports, only: [ :show, :index, :create, :update, :destroy ]
    post :visits, to: 'reports#create_visit'

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

  api_version(:module => "V1", :header => {:name => "Accept", :value => "application/com.ewin.echeckit; version=1"}) do 
  end

  api_version(:module => "V2", :header => {:name => "Accept", :value => "application/com.ewin.echeckit; version=2"}) do 
    current_api_routes.call
  end

  scope :module => :v1, &current_api_routes

end
