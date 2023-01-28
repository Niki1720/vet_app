require "rails_helper"

RSpec.describe CreateService do
  describe "#create" do
    let(:animal_params) { { name: "Lion", species: "Cat" } }

    it "creates a new animal" do
      service = CreateService.new
      created_animal = service.create(animal_params)
      expect(created_animal.name).to eq "Lion"
      expect(created_animal.species).to eq "Cat"
    end
  end
end
