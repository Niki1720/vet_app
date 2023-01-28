require 'rails_helper'

describe UserSerializer do
  let(:user) { create(:user, first_name: "Paulina", last_name: "Szarek", email: "xpaula20@wp.pl")}
  let!(:animal) { FactoryBot.create(:animal, user_id: user.id) }
  let(:serializer) { described_class.new(user) }
  let(:subject) { JSON.parse(serializer.to_json) }

  it 'includes the first_name attribute' do
    expect(subject['data']['attributes']['first_name']).to eq(user.first_name)
  end

  it 'includes the last_name attribute' do
    expect(subject['data']['attributes']['last_name']).to eq(user.last_name)
  end

  it 'includes the email attribute' do
    expect(subject['data']['attributes']['email']).to eq(user.email)
  end

  it 'includes the animal id attribute' do
    expect(subject['data']['relationships']['animals']['data'][0]['id']).to eq(animal.id.to_s)
    expect(subject['data']['relationships']['animals']['data'][0]['type']).to eq("animal")
  end
end
