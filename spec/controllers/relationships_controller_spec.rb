require 'rails_helper'
require "./spec/controllers/shared_test"

RSpec.describe RelationshipsController, type: :controller do

  include Shared_test

  let!(:user){User.first}
  let!(:user2){create(:user2)}
  before{ login(1) }

  describe "post create" do

    context "target user is myself" do
      it "Was not it saved in the database" do
        expect{
          post :create,params: {followed_id: user.id}, xhr: true
        }.to change(Relationship, :count).by(0)
      end
    end

    context "target user is other" do
      it "Was it saved in the database" do
        expect{
          post :create, params: {followed_id: user2.id}, xhr: true
        }.to change(Relationship, :count).by(1)
      end

      it "was the notification created?" do
        login(2)
        expect{
          post :create, params: {followed_id: user.id}, xhr: true
        }.to change(Notification, :count).by(1)
      end
    end
  end

  describe "delete destroy" do
    context "target user is myself" do
      before {FactoryBot.create(:follow)}

      it "Was it removed in the database" do
        expect{
          delete :destroy, params: {id: user.active_relationships.find_by(followed_id: user2.id)}, xhr: true
        }.to change(Relationship, :count).by(-1)
      end
    end

  end

end
