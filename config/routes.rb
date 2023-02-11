Rails.application.routes.draw do
  devise_for :users
  get 'phone_numbers/validate_number', to: 'phone_numbers#validate_number'
  resources :phone_numbers, only: [:index, :show, :new, :create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "phone_numbers#index"
end
