# frozen_string_literal: true

RSpec.describe UserSessions::CreateService do
  subject(:service) { described_class }

  context 'with valid parameters' do
    let!(:user) { create(:user, email: 'bob@example.com', password: 'givemeatoken') }

    it 'creates a new session' do
      expect { service.call('bob@example.com', 'givemeatoken') }
        .to change { UserSession.where(user_id: user.id).count }.from(0).to(1)
    end

    it 'assigns session' do
      result = service.call('bob@example.com', 'givemeatoken')

      expect(result.session).to be_a(UserSession)
    end
  end

  context 'when user is missing' do
    it 'does not create session' do
      expect { service.call('bob@example.com', 'givemeatoken') }
        .not_to change(UserSession, :count)
    end

    it 'adds an error' do
      result = service.call('bob@example.com', 'givemeatoken')

      expect(result).to be_failure
      expect(result.errors).to include('Сессия не может быть создана')
    end
  end

  context 'with invalid password' do
    before { create(:user, email: 'bob@example.com', password: 'givemeatoken') }

    it 'does not create session' do
      expect { service.call('bob@example.com', 'invalid') }
        .not_to change(UserSession, :count)
    end

    it 'adds an error' do
      result = service.call('bob@example.com', 'invalid')

      expect(result).to be_failure
      expect(result.errors).to include('Сессия не может быть создана')
    end
  end
end
