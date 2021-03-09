require 'rails_helper'

RSpec.describe Product, type: :model do

    let(:store){build(:store)}
    let(:product){build(:product)}

  it "name isn't less than 1 charactor" do
      product = store.products.build(name: "", price:1, description:"This is sample product", main_image: "sample.jpg")
      expect(product).not_to be_valid
  end


  it "is price exist?" do
      product = store.products.build(name: "sampleproduct", description:"This is sample product", main_image: "sample.jpg")
      expect(product).not_to be_valid
  end

  it "is description exist?" do
      product = store.products.build(name: "sampleproduct", price:1, main_image: "sample.jpg")
      expect(product).not_to be_valid
  end


  it "is product belongs to store?" do
     product = Product.new(name: "sampleproduct", price:1, description:"This is sample product", main_image: "sample.jpg")
     expect(product).not_to be_valid
  end

  it "isn't save same name" do
     store.products.build(name: "SampleProduct", price:100, description:"This is sample product", main_image: "sample.jpg")
     store.products.build(name: "SampleProduct", price:100, description:"This is sample product", main_image: "")
     expect(product).not_to be_valid
  end

  it "isn't save so cheep price" do
     product = store.products.build(name: "sampleproduct", price:0, description:"This is sample product", main_image: "sample.jpg")
     expect(product).not_to be_valid

  end

   it "isn't save so expensive price" do
     product = store.products.build(name: "sampleproduct", price:1000000, description:"This is sample product", main_image: "sample.jpg")
     expect(product).not_to be_valid

  end
end
