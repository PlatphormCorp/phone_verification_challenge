Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "verify_phone#index"

  resource :verification_request, only: [:create]

  resource :verification, only: [:show, :create]
end
