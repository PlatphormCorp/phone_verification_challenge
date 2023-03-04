Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'verify_phone#new'

  resources :verify_phone, as: :verify_phones
end
