# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
Sequel.migration do
  change do
    create_table(:schema_migrations) do
      column :filename, 'text', null: false

      primary_key [:filename]
    end

    create_table(:schema_seeds) do
      column :filename, 'text', null: false

      primary_key [:filename]
    end

    create_table(:users) do
      primary_key :id, type: :Bignum
      column :name, 'character varying', null: false
      column :email, 'character varying', null: false
      column :password_digest, 'character varying', null: false
      column :created_at, 'timestamp(6) without time zone', null: false
      column :updated_at, 'timestamp(6) without time zone', null: false

      index [:email], name: :index_users_on_email, unique: true
    end

    create_table(:user_sessions) do
      primary_key :id, type: :Bignum
      column :uuid, 'uuid', null: false
      foreign_key :user_id, :users, type: 'bigint', null: false, key: [:id]
      column :created_at, 'timestamp(6) without time zone', null: false
      column :updated_at, 'timestamp(6) without time zone', null: false

      index [:user_id], name: :index_user_sessions_on_user_id
      index [:uuid], name: :index_user_sessions_on_uuid
    end
  end
end
# rubocop:enable Metrics/BlockLength
