require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:user){build(:user)}
  let(:user2){build(:user2)}
  let(:store){build(:store)}
  let(:product){build(:product)}


   it "is notification belongs to user?" do
     notification = Notification.new(
     passive_user_id: user2.id,
     action: "sample")
     expect(notification).not_to be_valid
  end

  it "is exist passive_user_id?" do
    notification = user.active_notifications.new(
    action: "sample")
    expect(notification).not_to be_valid
  end

  it "is exist action?" do
    notification = user.active_notifications.new(
      passive_user_id: user2.id)
    expect(notification).not_to be_valid
  end

  it "isn't save less than 1 charactor" do
    notification = user.active_notifications.new(
      passive_user_id: user2.id,
      action: "")
    expect(notification).not_to be_valid
  end
end
