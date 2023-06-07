# frozen_string_literal: true

require_relative 'config/environment'

map '/' do
  run AuthRoutes
end
