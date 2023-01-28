require 'rails_helper'

RSpec.describe Animal, type: :model do
  context "name validations: name is present" do
    let(:animal) { create(:animal, name: "Pepsi", species: "Dog") }

    it "is valid" do
      expect(animal.valid?).to eq(true)
    end
  end

  context "name validations: name is empty" do
    let(:animal) { build(:animal, name: "") }

    it "is invalid" do
      expect(animal.valid?).to eq(false)
    end
  end

  context "name validations: name is nil" do
    let(:animal) { build(:animal, name: nil) }

    it "is invalid" do
      expect(animal.valid?).to eq(false)
    end
  end

  context "species validations: species is present" do
    let(:animal) { create(:animal, species: "Dog") }

    it "is valid" do
      expect(animal.valid?).to eq(true)
    end
  end

  context "species validations: species is empty" do
    let(:animal) { build(:animal, species: "") }

    it "is invalid" do
      expect(animal.valid?).to eq(false)
    end
  end

  context "species validations: species is nil" do
    let(:animal) { build(:animal, species: nil) }

    it "is invalid" do
      expect(animal.valid?).to eq(false)
    end
  end

  describe "#age_in_months" do
    context "when an animal birth is 2021/01/12" do
      it "return an animal with age as month" do
        animal = FactoryBot.create(:animal, name: 'Fluffy', species: 'Dog', birth: Date.new(2021, 02, 12))
        travel_to Time.zone.local(2022, 12, 24, 01, 04, 44) do
          expect(animal.age_in_months).to eq(10)
        end
      end
    end
  end

  describe ".is_beautiful?" do
    it "return true when animal is beautiful" do
      expect(described_class.is_beautiful?).to eq(true)
    end
  end
end
