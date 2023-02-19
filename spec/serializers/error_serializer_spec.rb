require 'rails_helper'

RSpec.describe ErrorSerializer do
  describe '#serialized_json' do
    let(:model) { double('model') }
    let(:error_serializer) { described_class.new(model) }
    let(:error_messages) do
      {
        name: ['can\'t be blank'],
        email: ['is invalid']
      }
    end

    before do
      allow(model).to receive_message_chain(:errors, :messages).and_return(error_messages)
    end

    it 'returns a serialized JSON with an error message for each attribute' do
      expected_json = [
        {
          status: '422',
          source: { pointer: '/data/attributes/name' },
          title: 'Invalid Attribute',
          detail: 'can\'t be blank'
        },
        {
          status: '422',
          source: { pointer: '/data/attributes/email' },
          title: 'Invalid Attribute',
          detail: 'is invalid'
        }
      ]

      expect(error_serializer.serialized_json).to match_array(expected_json)
    end
  end
end
