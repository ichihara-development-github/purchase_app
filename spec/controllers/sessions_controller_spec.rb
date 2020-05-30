require 'application_controller'

RSpec.describe SessionController, type: :controller do

  let(:user){build(:user)}

  it "get new" do
    get :new
    expect(response.status).to eq(200)
  end

end
