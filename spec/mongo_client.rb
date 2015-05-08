require "rails_helper"

describe MongoDbClient do

  context "query" do

    it "should find more than one record" do
      expect(subject.collection.find.to_a).not_to be_empty
    end

  end

  context "#upsert()" do
  end

end