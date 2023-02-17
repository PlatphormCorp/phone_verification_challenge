class ApiConnectionManager
  class ConfigurationError < StandardError; end
  CLIENT_CODE = "PhoneVerificationChallenge".freeze

  attr_reader :url,
              :auth_code,
              :connection,
              :phone_number,
              :message

  def initialize(url: Rails.application.credentials.api_url,
                 auth_code: Rails.application.credentials.auth_code,
                 phone_number: nil,
                 message: nil)

    @client = CLIENT_CODE
    @url = url
    @auth_code = auth_code
    @phone_number = phone_number
    @message = message
    @configuration_errors = []

    validate_configuration!
    @connection = configure_connection
  end

  def configure_connection
    Rails.logger.info "Configuring connection to #{url} with params: #{base_params.except(:auth_code)}}"
    Faraday.new(url: url, params: base_params)
  end

  def set_phone_number(phone_number)
    @phone_number = phone_number
    @connection.params[:phone_number] = @phone_number
    phone_number
  end

  def set_message(message)
    @message = message
    @connection.params[:message] = @message
    @message
  end

  def base_params
    {
      client: @client,
      auth_code: @auth_code,
      phone_number: @phone_number,
      message: @message
    }
  end

  private

  def validate_configuration!
    @configuration_errors << "Kwarg url is not configured, please set the api_url secret credential." if url.nil?
    @configuration_errors << "Kwarg auth_code is not configured, please set the auth_code secret credential." if auth_code.nil?

    raise ConfigurationError, @configuration_errors.join(' ') unless @configuration_errors.blank?
  end
end
