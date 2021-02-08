require 'rails_helper'

module HeraCms
  RSpec.describe Link, type: :model do
    let(:valid_attributes) {
      { identifier: "test-01", path: "https://www.hortatech.com.br", classes: "my-classes" }
    }

    let(:invalid_attributes) {
      { identifier: "test-invalid", classes: "my-classes" }
    }

    it "initializes sucessfully" do
      link = HeraCms::Link.create! valid_attributes
      expect(link.persisted?).to be(true)
    end
  end
end
