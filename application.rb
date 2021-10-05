# frozen_string_literal: true

require_relative './lib/router'
require_relative './lib/request_handler'
require_relative 'routes'
load 'db.initialization.rb'

class Application
  def call(env)
    request = Rack::Request.new(env)
    Router.resolve(request)
  rescue Router::RouteNotFound
    [404, {}, []]
  end
end
