# frozen_string_literal: true

RSpec.describe Users::CreateService do
  subject(:service) { described_class }

  context 'with valid parameters' do
    it 'creates a new user' do
      expect { service.call('bob', 'bob@example.com', 'givemeatoken') }
        .to change(User, :count).from(0).to(1)
    end

    it 'assigns user' do
      result = service.call('bob', 'bob@example.com', 'givemeatoken')

      expect(result.user).to be_a(User)
    end
  end

  context 'with invalid parameters' do
    it 'does not create user' do
      expect { service.call('bob', 'bob@example.com', '') }
        .not_to change(User, :count)
    end

    it 'assigns user' do
      result = service.call('bob', 'bob@example.com', '')

      expect(result.user).to be_a(User)
    end
  end
end
