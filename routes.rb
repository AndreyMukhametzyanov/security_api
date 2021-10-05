# frozen_string_literal: true
require_relative 'lib/router'

Router.define_routes do
  get %r{^/check_access$}, RequestHandler, :comparison
  post %r{^/check_access$}, RequestHandler, :comparison
  put %r{^/check_access$}, RequestHandler, :comparison
  delete %r{^/check_access$}, RequestHandler, :comparison
end