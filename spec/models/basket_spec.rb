require 'rails_helper'

RSpec.describe Basket, type: :model do
    before do
        @user_sample = User.new(name: "太郎", email: "taro@sample.com", password:"password")
        @user_sample.save
        store = Store.new(name: "SampleStore", top_image: "sample.jpg")
        store.save
        @production_sample = store.productions.build(name: "SampleProduction", description:"This is sample production", price: 1,main_image: "sample.jpg")
        @production_sample.save

    end
   it "is basket belongs to production?" do
     basket = @user_sample.baskets.build()
     expect(basket).to be_valid
  end
   it "is basket belongs to user?" do
      basket = Basket.new(production_id: @production_sample.id)
     expect(basket).not_to be_valid
  end


end
