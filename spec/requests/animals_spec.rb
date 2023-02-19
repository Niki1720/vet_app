require 'rails_helper'

RSpec.describe Api::V1::AnimalsController, type: :request do
  describe "GET /index" do
    it "returns a success response" do
      get '/api/v1/animals'

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /show" do
    it "returns a JSON response of a single animal" do
      user = FactoryBot.create(:user)
      animal = FactoryBot.create(:animal, name: 'Fluffy', species: 'Cat', user_id: user.id)

      get "/api/v1/animals/#{animal.id}"

      json = JSON.parse(response.body)
      expect(json['data']['attributes']['name']).to eq(animal.name)
      expect(json['data']['attributes']['species']).to eq(animal.species)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "with valid params" do
      it "returns a success response " do
        expect { post '/api/v1/animals', params: { name: 'Fido', species: 'Dog' } }.to change { Animal.count }.by(1)

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json['data']['attributes']['name']).to eq('Fido')
        expect(json['data']['attributes']['species']).to eq('Dog')
      end
    end

    context "with invalid params" do
      it "returns an unprocessable entity status" do
        post '/api/v1/animals', params: { name: '', species: 'Dog' }

        expect(response).to have_http_status(:unprocessable_entity)

        json = JSON.parse(response.body)
        expect(json['error']).to eq('Invalid parameters')
      end
    end
  end

  describe 'PATCH /animals/:id' do
    context "with valid params" do
      it 'updates an animal and returns a success response' do
        animal = FactoryBot.create(:animal, name: 'Fluffy', species: 'Dog')

        patch "/api/v1/animals/#{animal.id}", params: { name: 'Fido', species: 'Dog' }

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json['data']['attributes']['name']).to eq('Fido')
        expect(json['data']['attributes']['species']).to eq('Dog')
      end
    end

    context "with invalid params" do
      it 'updates an animal and returns an unprocessable entity status' do
        animal = FactoryBot.create(:animal, name: 'Dora', species: "Cat")

        patch "/api/v1/animals/#{animal.id}", params: { name: '', species: 'Dog' }

        expect(response).to have_http_status(:unprocessable_entity)

        json = JSON.parse(response.body)
        expect(json['error']).to eq('Invalid parameters')
      end
    end
  end

  describe "DELETE /destroy" do
    it 'deletes the animal and returns a success response' do
      animal = FactoryBot.create(:animal, name: 'Fluffy', species: 'Cat')

      delete "/api/v1/animals/#{animal.id}"
      expect(response).to have_http_status(:ok)
    end
  end
end
