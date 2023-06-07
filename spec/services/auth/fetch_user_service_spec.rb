# frozen_string_literal: true

RSpec.describe Auth::FetchUserService do
  subject(:service) { described_class }

  context 'with valid parameters' do
    let(:session) { create(:user_session) }

    it 'assigns user' do
      result = service.call(session.uuid)

      expect(result.user).to eq(session.user)
    end
  end

  context 'with invalid parameters' do
    it 'does not assign user' do
      result = service.call('FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF')

      expect(result.user).to be_nil
    end

    it 'adds an error' do
      result = service.call('FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF')

      expect(result).to be_failure
      expect(result.errors).to include('Доступ к ресурсу ограничен')
    end
  end
end
