require 'rails_helper'

RSpec.describe HeraCms::Link, type: :model do

  it "has a valid factory" do
    link = FactoryBot.create(:link)
    expect(link.class).to be(HeraCms::Link)
    expect(link).to be_valid
  end

  it "is valid with identifier, path, classes and style" do
    link = FactoryBot.build(:link)
    expect(link).to be_valid
  end

  it "is invalid without a path" do
    link = FactoryBot.build(:link, path: nil)
    link.valid?
    expect(link.errors[:path]).to include("can't be blank")
  end

  it "is invalid without an identifier" do
    link = FactoryBot.build(:link, identifier: nil)
    link.valid?
    expect(link.errors[:identifier]).to include("can't be blank")
  end

  it "is invalid with a duplicate identifier" do
    link_one = FactoryBot.create(:link)
    link_two = FactoryBot.build(:link)
    link_two.valid?
    expect(link_two.errors[:identifier]).to include("has already been taken")
  end
end
