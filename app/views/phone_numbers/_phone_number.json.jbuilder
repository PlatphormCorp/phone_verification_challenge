json.extract! phone_number, :id, :user_id, :phone_type, :number, :validated, :created_at, :updated_at
json.url phone_number_url(phone_number, format: :json)
