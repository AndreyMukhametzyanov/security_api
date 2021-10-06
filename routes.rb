# frozen_string_literal: true
require_relative 'lib/router'

Router.define_routes do
  post %r{^/check_access$}, RequestHandler, :comparison
end