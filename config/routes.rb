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

  # Inventories Route
  resources :inventories, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  # Admin Route (User & Roles)
  namespace :admin do
    resources :users
    resources :roles
  end

  # IoT routes for inventory management via IoT device
  resources :iot, only: [:index, :show] do
    post 'update_quantity', on: :member
  end

end
