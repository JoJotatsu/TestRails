require 'test_helper'

class HelloControllerTest < ActionDispatch::IntegrationTest
  test "should get find" do
    get hello_find_url
    assert_response :success
  end

end
