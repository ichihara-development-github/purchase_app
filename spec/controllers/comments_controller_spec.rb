require 'rails_helper'
require "./spec/controllers/shared_test"

RSpec.describe CommentsController, type: :controller do

  include Shared_test

  before do
     login
  end

  it "post create" do
    expect{
    post :create,
    params: {comment: {content:"This is a comment",
             id: 1,
             user_id: 1}},xhr: true}.to change(Comment, :count).by(1)
  end

  it "delete destroy" do
    comment = FactoryBot.create(:comment)
    expect{
     delete :destroy, params: {id: comment},xhr: true}.to change(Comment, :count).by(-1)
  end

end
