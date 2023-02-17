Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "phones#new"

  resources :phones, path: '/', only: [:new, :create, :update] do
    resources :verification_codes, only: :index do
      collection do
        post :verify
      end
    end
  end
end
