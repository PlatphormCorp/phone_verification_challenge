Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'verify_phone#index'

  post 'verification_code', to: 'verify_phone#code'
  post 'verify_code', to: 'verify_phone#verify'
end
