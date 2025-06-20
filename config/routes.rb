Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "dashboard#index"

  # Login route
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout

  # Dashboard Route
  get "/dashboard", to: "dashboard#index"

  # Admin Route (User & Roles)
  namespace :admin do
    resources :users
    resources :roles
  end

  # Customers Route
  resources :customers, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  # Equipments Route
  resources :equipments, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  # Inventories Route
  resources :inventories, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  # Jobs Route
  resources :jobs, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  post 'jobs/:id/create_first_job_process', to: 'jobs#create_first_job_process', as: 'create_first_job_process'

  # IoT routes for inventory management via IoT device
  resources :iot, only: [:index, :show] do
    post 'update_quantity', on: :member
  end

  # API for Inventory Log Route
  namespace :api do
    resources :inventory_logs, only: [:index, :create, :update] do
      member do
        patch :update_inventory
      end
    end
  end

  # IOT API
  Rails.application.routes.draw do
    namespace :iot do
      scope :api do
        get '/', to: 'iot_api#index'
        post '/', to: 'iot_api#create'
        patch '/:id', to: 'iot_api#update'
      end
    end
  end

  # Job Order route
  resources :job_processes, only: [:index, :show, :update] do
    member do
      post :create_log
        post :log_process               # POST /job_processes/:id/log_process
    end
    collection do
      post :create_process
    end
  end
  get 'job_processes/:job_id', to: 'job_processes#show', as: 'show_job_processes'
  post 'job_processes/:id/upload_photos', to: 'job_processes#upload_photos', as: 'upload_job_photos'
  

  # Job process log route

end
