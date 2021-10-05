# frozen_string_literal: true

require_relative 'request_handler'
require 'json'
require 'singleton'

class Router
  include Singleton

  class RouteNotFound < StandardError; end

  METHODS = %i[get post put patch delete].freeze

  attr_reader :routes

  def initialize
    @routes = []
  end

  class << self
    def routes
      instance.routes
    end

    def define_routes(&block)
      instance.instance_eval(&block)
    end

    def resolve(request)
      route_data, uri_params = instance.send(:find_route, request.request_method, request.path_info)
      instance.send(:run_handler, route_data, request, uri_params)
    end
  end

  private

  METHODS.each do |method|
    define_method(method) do |pattern, handler, action|
      add_route(method, pattern, handler, action)
    end
  end

  def find_route(method, path)
    route_data = routes.find { |route| route[:method] == method.to_sym.downcase && route[:pattern] =~ path }
    raise RouteNotFound unless route_data

    [route_data, Regexp.last_match&.named_captures]
  end

  def run_handler(route_data, request, uri_params)
    route_data[:handler].new(request, uri_params).send(route_data[:action])
  end

  def add_route(method, pattern, handler, action)
    @routes << {
      method: method,
      pattern: pattern,
      handler: handler,
      action: action
    }
  end
end