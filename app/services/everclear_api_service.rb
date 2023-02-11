require 'net/http'
require 'dotenv'
require 'json'
Dotenv.load

class EverclearApiService
  BASE_URL = 'https://fallow-badger-7481.twil.io'

  def send_api_call(method:, path:, parameters:)
    full_url = "#{BASE_URL}#{path}"
    auth_parameters = { client: ENV['EVERCLEAR_CLIENT'], authorization_code: ENV['EVERCLEAR_AUTHORIZATION_CODE']}
    uri = URI(full_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    if method.downcase == 'get'
        uri.query = URI.encode_www_form(auth_parameters.merge(parameters))
        request = Net::HTTP::Get.new(uri)
        request.body = parameters.to_json
    elsif method.downcase == 'post'
      uri.query = URI.encode_www_form(auth_parameters)
        request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
        request.body = parameters.to_json
    else
        throw "The HTTP method #{method} is not currently supported."
    end
    response = http.request(request)
    begin
      body = JSON.parse(response.body)
    rescue => ex
      puts "#{ex.message}\n#{ex.backtrace.join("\n")}"
      throw 'Invalid API call'
    end
    return { status: response.code, data: body }
  end

  def send_sms(phone_number:, message:)
    path = '/sendsms'
    response = send_api_call(method: 'get', path: path, parameters: { phone_number: phone_number, message: message})
    return response
  end
end