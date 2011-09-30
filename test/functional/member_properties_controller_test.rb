require 'test_helper'

class MemberPropertiesControllerTest < ActionController::TestCase
  setup do
    @member_property = member_properties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:member_properties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member_property" do
    assert_difference('MemberProperty.count') do
      post :create, :member_property => @member_property.attributes
    end

    assert_redirected_to member_property_path(assigns(:member_property))
  end

  test "should show member_property" do
    get :show, :id => @member_property.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @member_property.to_param
    assert_response :success
  end

  test "should update member_property" do
    put :update, :id => @member_property.to_param, :member_property => @member_property.attributes
    assert_redirected_to member_property_path(assigns(:member_property))
  end

  test "should destroy member_property" do
    assert_difference('MemberProperty.count', -1) do
      delete :destroy, :id => @member_property.to_param
    end

    assert_redirected_to member_properties_path
  end
end
