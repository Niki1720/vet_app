require "rails_helper"

RSpec.describe UpdateService do
  describe "#update" do
    let(:animal) { create(:animal) }
    let(:animal_params) { { name: "new name", species: "new species" } }

    it "updates the animal" do
      service = UpdateService.new
      updated_animal = service.update(animal.id, animal_params)
      expect(updated_animal.name).to eq "new name"
      expect(updated_animal.species).to eq "new species"
    end
  end
end
