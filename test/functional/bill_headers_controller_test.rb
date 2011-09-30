require 'test_helper'

class BillHeadersControllerTest < ActionController::TestCase
  setup do
    @bill_header = bill_headers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bill_headers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bill_header" do
    assert_difference('BillHeader.count') do
      post :create, :bill_header => @bill_header.attributes
    end

    assert_redirected_to bill_header_path(assigns(:bill_header))
  end

  test "should show bill_header" do
    get :show, :id => @bill_header.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @bill_header.to_param
    assert_response :success
  end

  test "should update bill_header" do
    put :update, :id => @bill_header.to_param, :bill_header => @bill_header.attributes
    assert_redirected_to bill_header_path(assigns(:bill_header))
  end

  test "should destroy bill_header" do
    assert_difference('BillHeader.count', -1) do
      delete :destroy, :id => @bill_header.to_param
    end

    assert_redirected_to bill_headers_path
  end
end
