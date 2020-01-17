require 'rails_helper'

RSpec.describe Store, type: :model do
   before do
        store_sample = Store.new(name: "SampleStore", top_image: "sample.jpg")
        store_sample.save
    end
  it "name isn't less than 1 charactor" do
      store = Store.new
      expect(store).not_to be_valid
  end
  
  it "is top_image exist?" do
      store = Store.new(name: "samplestore")
      expect(store).not_to be_valid
  end
  
   
  it "isn't  save same name" do
     store = Store.new(name: "SampleStore", top_image: "sample.jpg")
     expect(store).not_to be_valid
  
  end
end
