require 'rails_helper'

RSpec.describe Comment, type: :model do
   before do
        @user_sample = User.new(name: "太郎", email: "taro@sample.com", password:"password")
        @user_sample.save
        store = Store.new(name: "SampleStore", top_image: "sample.jpg")
        store.save
        @production_sample = store.productions.build(name: "SampleProduction", description:"This is sample production", price: 1,main_image: "sample.jpg")
        @production_sample.save
    end
    
   it "is comment belongs to production?" do
     comment = @user_sample.comments.build(content: "hoge fuga piyo")
     expect(comment).not_to be_valid
  end
  
   it "is comment belongs to user?" do
     comment = Comment.new(content: "hoge fuga piyo",production_id: @production_sample.id)
     expect(comment).not_to be_valid
  end
  
  it "isn't save less than 1 charactor" do
      comment = @user_sample.comments.build(production_id: @production_sample.id)
     expect(comment).not_to be_valid
      
  end
  
end
