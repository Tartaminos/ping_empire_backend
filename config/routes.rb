Rails.application.routes.draw do
  resources :users
  resources :jobs

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  Rails.application.routes.draw do
    namespace :api do
      resources :endpoints
      resources :users

      post "/register", to: "users#register"
      post "/login", to: "users#login"
    end
  end

  # options

  match "*path", to: "application#options", via: :options
end
