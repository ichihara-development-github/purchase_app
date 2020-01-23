require 'rails_helper'

RSpec.describe Production, type: :model do
   before do
        @store = Store.new(name: "SampleStore", top_image: "sample.jpg")
        @store.save
        production_sample = @store.productions.build(name: "SampleProduction", description:"This is sample production", price: 1,main_image: "sample.jpg")
        production_sample.save
       
    end
    
  it "name isn't less than 1 charactor" do
      production = @store.productions.build(name: "", price:1, description:"This is sample production", main_image: "sample.jpg")
      expect(production).not_to be_valid
  end
 
  
  it "is price exist?" do
      production = @store.productions.build(name: "sampleproduction", description:"This is sample production", main_image: "sample.jpg")
      expect(production).not_to be_valid
  end
  
  it "is description exist?" do
      production = @store.productions.build(name: "sampleproduction", price:1, main_image: "sample.jpg")
      expect(production).not_to be_valid
  end
  
  
  it "is production belongs to store?" do
     production = Production.new(name: "sampleproduction", price:1, description:"This is sample production", main_image: "sample.jpg")
     expect(production).not_to be_valid
  end
   
  it "isn't save same name" do
     production = @store.productions.build(name: "SampleProduction", price:1, description:"This is sample production", main_image: "sample.jpg")
     expect(production).not_to be_valid
  end
  
  it "isn't save so cheep price" do
     production = @store.productions.build(name: "sampleproduction", price:0, description:"This is sample production", main_image: "sample.jpg")
     expect(production).not_to be_valid
  
  end
  
   it "isn't save so expensive price" do
     production = @store.productions.build(name: "sampleproduction", price:1000000, description:"This is sample production", main_image: "sample.jpg")
     expect(production).not_to be_valid
  
  end
end
