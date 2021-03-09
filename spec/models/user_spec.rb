require 'rails_helper'

RSpec.describe User, type: :model do

    it "is name exist?" do
        user = User.new(email:"hogehoge@user.com", password: "password", address: "東京")
        expect(user).not_to be_valid
    end

    it "password isn't less than 1 charactors " do
       user = User.new(name: "", email: "jiro@sammple.com", password: "password",  address: "東京")
       expect(user).not_to be_valid
   end

    it "isn't save same name user" do
        user = User.new(name: "user", email: "taro@example.com", password: "password",  address: "東京")
        expect(user).not_to be_valid
    end

    it "is email exist?" do
        user = User.new(name:"user", password: "password",  address: "東京")
        expect(user).not_to be_valid
    end

    it "isn't save same email user" do
        user = User.new(name: "user2", email: "user@user.com",password: "password",  address: "東京")
        expect(user).not_to be_valid
    end

    it "isn't save incorrect format email" do
        user = User.new(name: "二郎", email: "user2.user.com",password: "password",  address: "東京")
        expect(user).not_to be_valid
    end

    it "is password exist?" do
        user = User.new(name:"user2", email: "user2@user.com",  address: "東京")
        expect(user).not_to be_valid
    end

   it "password isn't less than 6 charactors " do
      user = User.new(name: "user2", email: "user2@user.com", password: "passw",  address: "東京")
      expect(user).not_to be_valid
  end

end
