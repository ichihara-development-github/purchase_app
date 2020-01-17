require 'rails_helper'

RSpec.describe Purchaced, type: :model do
    before do
        @user_sample = User.new(name: "太郎", email: "taro@sample.com", password:"password")
        @user_sample.save
        store = Store.new(name: "SampleStore", top_image: "sample.jpg")
        store.save
        @production_sample = store.productions.build(name: "SampleProduction", description:"This is sample production", price: 1,main_image: "sample.jpg")
        @production_sample.save
    
    end
   it "is purchaecd belongs to production?" do
     purchaced = @user_sample.purchaceds.build()
     expect(purchaced).not_to be_valid
  end
   it "is purcahced belongs to user?" do
      purchaced = Purchaced.new(production_id: @production_sample.id)
     expect(purchaced).not_to be_valid
  end
  
end