require 'test_helper'

class MeetingMembersControllerTest < ActionController::TestCase
  setup do
    @meeting_member = meeting_members(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meeting_members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meeting_member" do
    assert_difference('MeetingMember.count') do
      post :create, :meeting_member => @meeting_member.attributes
    end

    assert_redirected_to meeting_member_path(assigns(:meeting_member))
  end

  test "should show meeting_member" do
    get :show, :id => @meeting_member.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @meeting_member.to_param
    assert_response :success
  end

  test "should update meeting_member" do
    put :update, :id => @meeting_member.to_param, :meeting_member => @meeting_member.attributes
    assert_redirected_to meeting_member_path(assigns(:meeting_member))
  end

  test "should destroy meeting_member" do
    assert_difference('MeetingMember.count', -1) do
      delete :destroy, :id => @meeting_member.to_param
    end

    assert_redirected_to meeting_members_path
  end
end
