require 'rails_helper'

RSpec.describe User, type: :model do
    before do
        user_sample = User.new(name: "太郎", email: "taro@sample.com", password:"password")
        user_sample.save
    end
  it "isn't less than 1 charactor" do
      user = User.new
      expect(user).not_to be_valid
  end
  
   it "password isn't less than 6 charactors " do
      user = User.new(name: "二郎", email: "jiro@sammple.com", password: "passw")
      expect(user).not_to be_valid
  end
  
  it "isn't save same name user" do
      user = User.new(name: "太郎", email: "taro@example.com", password: "password")
      expect(user).not_to be_valid
  end
  
  it "isn't save same email user" do
      user = User.new(name: "二郎", email: "taro@sample.com",password: "password")
      expect(user).not_to be_valid
  end
  
  it "isn't save incorrect format email" do
      user = User.new(name: "二郎", email: "jiro.sample.com",password: "password")
      expect(user).not_to be_valid
  end
  
  
end
