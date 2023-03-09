Rails.application.routes.draw do
  root "verify_phone#index"
  post '/verify_phone', to: 'verify_phone#create'
  post '/verify_phone/verification_code', to: 'verify_phone#verification_code'
end
