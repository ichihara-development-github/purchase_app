require 'test_helper'

class PurcahceControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get purcahce_new_url
    assert_response :success
  end

end
