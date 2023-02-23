require 'rails_helper'

RSpec.describe Api::V1::AnimalsController, type: :request do
  describe "GET /index" do
    it "returns a success response" do
      user = FactoryBot.create(:user)

      get "/api/v1/animals?user_id=#{user.id}"
      expect(response).to have_http_status(:ok)
    end

    it "returns an error response for invalid request" do
      invalid_user_id = 9999

      get "/api/v1/animals?user_id=#{invalid_user_id}"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /show" do
    it "returns a JSON response of a single animal" do
      user = FactoryBot.create(:user)
      animal = FactoryBot.create(:animal, name: 'Fluffy', species: 'Cat', user_id: user.id)

      get "/api/v1/animals/#{animal.id}?user_id=#{user.id}"
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json['data']['attributes']['name']).to eq(animal.name)
      expect(json['data']['attributes']['species']).to eq(animal.species)
    end

    it "returns an error response for invalid request" do
      invalid_user_id = 9999
      animal = FactoryBot.create(:animal, name: 'Fluffy', species: 'Cat', user_id: invalid_user_id)

      get "/api/v1/animals/#{animal.id}?user_id=#{invalid_user_id}"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /create" do
    context "with valid params" do
      it "returns a success response " do
        user = FactoryBot.create(:user)
        expect { post '/api/v1/animals', params: { name: 'Fido', species: 'Dog', user_id: user.id } }.to change { Animal.count }.by(1)
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json['data']['attributes']['name']).to eq('Fido')
        expect(json['data']['attributes']['species']).to eq('Dog')
      end
    end

    context "with invalid params" do
      it "returns an unprocessable entity status" do
        post '/api/v1/animals', params: { name: '', species: 'Dog' }
        expect(response).to have_http_status(:not_found)

        json = JSON.parse(response.body)
        expect(json['error']).to eq('Couldn\'t find User without an ID')
      end
    end
  end

  describe 'PATCH /animals/:id' do
    context "with valid params" do
      it 'updates an animal and returns a success response' do
        user = FactoryBot.create(:user)
        animal = FactoryBot.create(:animal, name: 'Fluffy', species: 'Dog')

        patch "/api/v1/animals/#{animal.id}", params: { name: 'Fido', species: 'Dog', user_id: user.id }
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
        expect(response).to have_http_status(:not_found)

        json = JSON.parse(response.body)
        expect(json['error']).to eq('Couldn\'t find User without an ID')
      end
    end
  end

  describe "DELETE /destroy" do
    it 'deletes the animal and returns a success response' do
      user = FactoryBot.create(:user)
      animal = FactoryBot.create(:animal, name: 'Fluffy', species: 'Cat', user_id: user.id)

      delete "/api/v1/animals/#{animal.id}?user_id=#{user.id}"
      expect(response).to have_http_status(:ok)
    end

    it "returns an error response for invalid request" do
      invalid_user_id = 9999
      animal = FactoryBot.create(:animal, name: 'Fluffy', species: 'Cat', user_id: invalid_user_id)

      delete "/api/v1/animals/#{animal.id}?user_id=#{invalid_user_id}"
      expect(response).to have_http_status(:not_found)
    end
  end
end
