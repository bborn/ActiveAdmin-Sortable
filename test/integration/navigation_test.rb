require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest


  test "login and view sort_position page" do
    get admin_pages_path
    
    assert_response :success

  end
  
  
end

