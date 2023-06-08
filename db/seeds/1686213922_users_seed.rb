# frozen_string_literal: true

Sequel.seed(:development) do
  def run
    User.create name: 'Bob', email: 'bob@example.com', password: 'givemeatoken'
  end
end
