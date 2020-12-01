RSpec.describe HeraCms do
  it "has a version number" do
    expect(HeraCms::VERSION).not_to be nil
  end

  describe "#test" do
    it "returns a successful message" do
      expect(HeraCms.test).to eq("Successful")
    end
  end
end
