require 'test_helper'

class PostSettingsControllerTest < ActionController::TestCase
  setup do
    @post_setting = post_settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:post_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post_setting" do
    assert_difference('PostSetting.count') do
      post :create, post_setting: { allow_comments: @post_setting.allow_comments, posts_per_page: @post_setting.posts_per_page }
    end

    assert_redirected_to post_setting_path(assigns(:post_setting))
  end

  test "should show post_setting" do
    get :show, id: @post_setting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post_setting
    assert_response :success
  end

  test "should update post_setting" do
    patch :update, id: @post_setting, post_setting: { allow_comments: @post_setting.allow_comments, posts_per_page: @post_setting.posts_per_page }
    assert_redirected_to post_setting_path(assigns(:post_setting))
  end

  test "should destroy post_setting" do
    assert_difference('PostSetting.count', -1) do
      delete :destroy, id: @post_setting
    end

    assert_redirected_to post_settings_path
  end
end
