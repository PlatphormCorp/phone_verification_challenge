class ApplicationController < ActionController::Base
  after_action :add_csrf_token_to_json_request_header

  private

  def add_csrf_token_to_json_request_header # we are doing this to refresh the authenticity token since we make async calls
    unless request.get?
      response.headers['X-CSRF-Token'] = form_authenticity_token
    end
  end
end
