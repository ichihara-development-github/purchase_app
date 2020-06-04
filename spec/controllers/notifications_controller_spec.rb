require 'rails_helper'
require "./spec/controllers/shared_test"

RSpec.describe NotificationsController, type: :controller do

  include Shared_test

  # describe "when comment was created" do
  #   it "is notification created?" do
  #     login
  #     debugger
  #     expect{
  #     post :create,
  #     params: {comments: attributes_for(:comment)}}.to change(Notification, :count).by(1)
  #   end
  #
  # end

  # describe "when customer purchased products" do
  #   before{ login }
  #   it "is notification created?" do
  #     expect{
  #     post :create,
  #     params: {purchaced: attributes_for(:)}}.to change(Notification, :count).by(1)
  #   end
  # end

end
