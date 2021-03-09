require 'rails_helper'
require "./spec/controllers/shared_test"

RSpec.describe CommentsController, type: :controller do

  include Shared_test

  before do
     login(1)
  end

  describe "post create" do
    it "was it saved in database?" do
      expect{
      post :create,
      params: {comment: {content:"This is a comment",
               id: 1}},xhr: true}.to change(Comment, :count).by(1)
    end

    it "was the notification created?" do
      FactoryBot.create(:user2)
      login(2)

      expect{
      post :create,
      params: {comment: {content:"This s a comment",
               id: 1}},xhr: true}.to change(Notification, :count).by(1)
    end
  end

  it "delete destroy" do
    comment = FactoryBot.create(:comment)
    expect{
     delete :destroy, params: {id: comment},xhr: true}.to change(Comment, :count).by(-1)
  end

end
