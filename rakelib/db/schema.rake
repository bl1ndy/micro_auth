# frozen_string_literal: true

namespace :db do
  namespace :schema do
    desc 'Create file with DB schema'
    task :dump, %i[db] do |_, args|
      db = args[:db]
      db.extension :schema_dumper
      dump = db.dump_schema_migration(same_db: true)

      File.write('./db/schema.rb', dump)
    end
  end
end
