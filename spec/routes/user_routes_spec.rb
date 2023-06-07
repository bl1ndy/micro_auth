# frozen_string_literal: true

RSpec.describe UserRoutes, type: :routes do
  describe 'POST /' do
    context 'with missing parameters' do
      it 'returns an error' do
        post '/', { name: 'bob', email: 'bob@example.com', password: '' }

        expect(last_response.status).to eq(422)
      end
    end

    context 'with invalid parameters' do
      it 'returns an error' do
        post '/', { name: 'b.o.b', email: 'bob@example.com', password: 'givemeatoken' }

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Используйте только буквы, цифры или символ подчеркивания',
            'source' => {
              'pointer' => '/data/attributes/name'
            }
          }
        )
      end
    end

    context 'with valid parameters' do
      it 'returns created status' do
        post '/', { name: 'bob', email: 'bob@example.com', password: 'givemeatoken' }

        expect(last_response.status).to eq(201)
      end
    end
  end
end
