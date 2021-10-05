# frozen_string_literal: true

require_relative './lib/router'

class Application
  def call(env)
    request = Rack::Request.new(env)
    Router.resolve(request)
  rescue Router::RouteNotFound
    [404, {}, []]
  end
end
