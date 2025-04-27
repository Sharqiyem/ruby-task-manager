Rails.application.routes.draw do
   
   # Home route
  root 'home#index'

  devise_for :users

  # Authenticated user routes
  authenticate :user do
    get 'dashboard', to: 'tasks#dashboard', as: :dashboard
    resources :tasks do
      member do
        patch :update_status
      end
    end
  end

  # Public pages
  get 'about', to: 'home#about'
  get 'contact', to: 'home#contact'
  get 'pricing', to: 'home#pricing'

  # Error routes
  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unprocessable_entity", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  
end