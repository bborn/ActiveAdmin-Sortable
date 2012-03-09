require 'test_helper'

class ActiveAdminSortableTest < ActionController::TestCase
  include Devise::TestHelpers
  
  tests Admin::PagesController

  setup do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    @admin = Factory(:admin_user)
    sign_in @admin    
    
    5.times{ Factory(:page) }
  end  
    
  test "should get index" do
    get :index
    assert_response :success
  end
  
  test "should get sort position" do
    get :sort_position
    assert_response :success
    assert !assigns(:pages).empty?
  end
  
  test "should update sort position" do
    page = Page.order(:position).last
    assert_equal page.position, 4
    post :update_sort_position, :page => Page.all.map(&:id).reverse
    assert_response :success
    assert_equal page.reload.position, 0
  end
  
  
end
