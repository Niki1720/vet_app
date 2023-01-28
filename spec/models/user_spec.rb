require 'rails_helper'

RSpec.describe User, type: :model do

  context "first_name validations: first_name is present" do
    let(:user) { create(:user, first_name: "Paulina") }

    it "is valid" do
      expect(user.valid?).to eq(true)
    end
  end

  context "first_name validations: first_name is empty" do
    let(:user) { build(:user, first_name: "") }

    it "is invalid" do
      expect(user.valid?).to eq(false)
    end
  end

  context "first_name validations: first_name is nil" do
    let(:user) { build(:user, first_name: nil) }

    it "is invalid" do
      expect(user.valid?).to eq(false)
    end
  end

  context "last_name validations: last_name is present" do
    let(:user) { create(:user, last_name: "Pelczar") }

    it "is valid" do
      expect(user.valid?).to eq(true)
    end
  end

  context "last_name validations: last_name is empty" do
    let(:user) { build(:user, last_name: "") }

    it "is invalid" do
      expect(user.valid?).to eq(false)
    end
  end

  context "last_name validations: last_name is nil" do
    let(:user) { build(:user, last_name: nil) }

    it "is invalid" do
      expect(user.valid?).to eq(false)
    end
  end


  context "email validations: email is present" do
    let(:user) { create(:user, email: "user@wp.pl") }

    it "is valid" do
      expect(user.valid?).to eq(true)
    end
  end

  context "email validations: email is uniq" do
    let!(:user) { create(:user, email: "user@wp.pl") }
    let(:user2) { build(:user, email: "user@wp.pl") }

    it "is valid" do
      expect(user2.valid?).to eq(false)
    end
  end

  context "email validations: email is empty" do
    let(:user) { build(:user, email: "") }

    it "is invalid" do
      expect(user.valid?).to eq(false)
    end
  end

  context "email validations: email is nil" do
    let(:user) { build(:user, email: nil) }

    it "is invalid" do
      expect(user.valid?).to eq(false)
    end
  end
end
