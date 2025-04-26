Rails.application.routes.draw do
   
  root 'home#index'
  get '/dashboard', to: 'home#dashboard'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

 
  # get '/dashboard', to: 'home#dashboard', as: 'dashboard'
  # root to: "home#dashboard"  # Redirect here after login

  resources :tasks do
    member do
      patch :update_status
    end
  end
  
  authenticated :user do
    root to: 'tasks#index', as: :authenticated_root
  end
end