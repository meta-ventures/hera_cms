require 'rails_helper'

RSpec.describe HeraCms::Link, type: :model do
  let(:valid_attributes) {
    { identifier: "test-01", path: "https://www.hortatech.com.br", classes: "my-classes" }
  }

  let(:invalid_attributes) {
    { identifier: "test-invalid", classes: "my-classes" }
  }

  it "has a valid factory" do
    link = FactoryBot.create(:link)
    expect(link).to be_valid
  end

  it "is valid with identifier, path, classes and style" do
    link = HeraCms::Link.new({ identifier: "test-01", path: "https://www.hortatech.com.br", classes: "my-classes", style: "color: red;" })
    expect(link).to be_valid
  end

  it "is invalid without a path" do
    link = HeraCms::Link.new({ identifier: "test-invalid", classes: "my-classes" })
    link.valid?
    expect(link.errors[:path]).to include("can't be blank")
  end

  it "is invalid without an identifier" do
    link = HeraCms::Link.new({ path: "https://www.hortatech.com.br", classes: "my-classes" })
    link.valid?
    expect(link.errors[:identifier]).to include("can't be blank")
  end

  it "is invalid with a duplicate identifier" do
    link_one = HeraCms::Link.create({ identifier: "test-01", path: "https://www.google.com.br", classes: "other-classes", style: "color: blue;" })
    link_two = HeraCms::Link.new({ identifier: "test-01", path: "https://www.hortatech.com.br", classes: "my-classes", style: "color: red;" })
    link_two.valid?
    expect(link_two.errors[:identifier]).to include("has already been taken")
  end
end
