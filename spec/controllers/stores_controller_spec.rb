require "./spec/controllers/shared_test"
require 'rails_helper'

RSpec.describe StoresController, type: :controller do

  include Shared_test

  describe "default test" do
    it_behaves_like "default_test", Store
  end

  describe "get edit" do
    let!(:store){Store.first}

    context "user has store or admin" do

        before do
          login(1)
          get :edit, params: {id: store.id}
        end

        it "assign the requested object to @object" do
          expect(assigns(:store)).to eq store
        end

        it "is http request success?" do
          expect(response).to have_http_status 200
          Store.destroy_all
        end
      end

    context "user has not authority" do
      before do
        get :edit, params: {id: store.id}
      end
      it_behaves_like "redirect to root if user is not seller"
    end
  end

end
