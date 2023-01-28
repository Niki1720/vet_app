require 'rails_helper'

describe AnimalSerializer do
  let(:animal) { create(:animal, name: "Pepsi", species: "Dog", birth: Date.new(2021,10,15), death: Date.new(2022,01,10), user_id: user.id) }
  let(:user) { FactoryBot.create(:user) }
  let(:serializer) { described_class.new(animal) }
  let(:subject) { JSON.parse(serializer.to_json) }

  it 'includes the name attribute' do
    expect(subject['data']['attributes']['name']).to eq(animal.name)
  end

  it 'includes the species attribute' do
    expect(subject['data']['attributes']['species']).to eq(animal.species)
  end

  it 'includes the birth attribute' do
    expect(subject['data']['attributes']['birth']).to eq("2021-10-15")
  end

  it 'includes the death attribute' do
    expect(subject['data']['attributes']['death']).to eq("2022-01-10")
  end

  it 'includes the user id attribute' do
    expect(subject['data']['relationships']['user']['data']['id']).to eq(animal.user_id.to_s)
  end
end
