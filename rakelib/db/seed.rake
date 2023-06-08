# frozen_string_literal: true

namespace :db do
  desc 'Populate DB with seeds'
  task seed: :settings do
    require 'sequel/core'
    require 'sequel/extensions/seed'
    require_relative '../../config/environment'

    Sequel::Seed.setup :development
    Sequel.extension :seed

    Sequel.connect(Settings.db.to_hash) do |db|
      Sequel::Seeder.apply(db, File.expand_path('../../db/seeds/', __dir__))
    end
  end
end
