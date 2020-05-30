require "./spec/controllers/shared_test"
require 'rails_helper'

RSpec.describe StoresController, type: :controller do

  include Shared_test

  before do
  @user = User.first
  allow(controller)
    .to receive(:current_user)
    .and_return(@user)
  end

  describe "default test" do
    it_behaves_like "default_test", Store
  end


end
