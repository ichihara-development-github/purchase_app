require 'rails_helper'

RSpec.describe Store, type: :model do
  let(:user){build(:user)}

  it "is name exist?" do
      store = user.build_store(description:"This is sample store", address: "東京")
      expect(store).not_to be_valid
  end

  it "name isn't less than 1 charactor" do
      store = user.build_store(name:"", address: "東京")
      expect(store).not_to be_valid
  end

  it "is description exist?" do
      store = user.build_store(name:"store", address: "東京")
      expect(store).not_to be_valid
  end

  it "is store belongs to user?" do
    store = Store.new(name:"sample_store", address: "東京")
     expect(store).not_to be_valid
  end

  it "isn't save same name" do
     store = build(:store)
     store = user.build_store(name:"store", address: "東京")
     expect(store).not_to be_valid
  end

end
