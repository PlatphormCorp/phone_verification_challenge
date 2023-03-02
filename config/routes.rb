Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "verify_phone#index"

  resources :phone, only: [] do
    resources :verify_code, only: [:create]
  end

  resources :verify_phone, only: [:create]
end
