require 'test_helper'

class BillSetupsControllerTest < ActionController::TestCase
  setup do
    @bill_setup = bill_setups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bill_setups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bill_setup" do
    assert_difference('BillSetup.count') do
      post :create, :bill_setup => @bill_setup.attributes
    end

    assert_redirected_to bill_setup_path(assigns(:bill_setup))
  end

  test "should show bill_setup" do
    get :show, :id => @bill_setup.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @bill_setup.to_param
    assert_response :success
  end

  test "should update bill_setup" do
    put :update, :id => @bill_setup.to_param, :bill_setup => @bill_setup.attributes
    assert_redirected_to bill_setup_path(assigns(:bill_setup))
  end

  test "should destroy bill_setup" do
    assert_difference('BillSetup.count', -1) do
      delete :destroy, :id => @bill_setup.to_param
    end

    assert_redirected_to bill_setups_path
  end
end
