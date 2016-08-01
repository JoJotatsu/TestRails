require 'test_helper'

class HelloControllerTest < ActionDispatch::IntegrationTest
  test "should get find" do
    get hello_find_url
    assert_response :success
  end

  test "list action" do
    get :list
    assert_equal 10, assigns(:book).length, 'found rows is wrong'
    assert_response :success, 'list axtion failed'
    assert_template 'hello/list'
  end

end
