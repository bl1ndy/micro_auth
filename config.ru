# frozen_string_literal: true

require_relative 'config/environment'

map '/' do
  run AuthRoutes
end

map '/login' do
  run UserSessionRoutes
end

map '/signup' do
  run UserRoutes
end
