# frozen_string_literal: true

namespace :db do
  namespace :schema do
    desc 'Create file with DB schema'
    task dump: :settings do
      db = Settings.db.to_h

      `sequel -D #{db[:adapter]}://#{db[:user]}:#{db[:password]}@#{db[:host]}/#{db[:database]} > ./db/schema.rb`
    end
  end
end
