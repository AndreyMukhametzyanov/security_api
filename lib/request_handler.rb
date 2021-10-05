# frozen_string_literal: true
require_relative 'secret_users'
require_relative 'router'
require 'json'

class RequestHandler

  attr_reader :request, :params

  def initialize(request, url_params)
    @request = request
    @url_params = url_params
  end

  def comparison
    result = SecretUsers.find_by_params(@url_params['phone'], @request.request_method)
    puts result
    if result.nil?
      ok_response({ 'service_conclusion' => 'accepted' })
    else
      ok_response({ 'service_conclusion' => 'forbidden', 'reason' => result['reason'] })
    end
  end

  private

  def ok_response(content)
    [200, { 'Content-Type' => 'application/json' }, [JSON.generate(content)]]
  end
end
