# frozen_string_literal: true

namespace :db do
  desc 'Run database migrations'
  task :migrate, %i[version] => :settings do |_, args|
    require 'sequel/core'
    Sequel.extension :migration

    db = Sequel.connect(Settings.db.to_hash)
    migrations = File.expand_path('../../db/migrations', __dir__)
    version = args.version.to_i if args.version

    Sequel::Migrator.run(db, migrations, target: version)

    Rake::Task['db:schema:dump'].invoke(db)
  end
end
