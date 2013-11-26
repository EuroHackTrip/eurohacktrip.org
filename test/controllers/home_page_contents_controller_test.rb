require 'test_helper'

class HomePageContentsControllerTest < ActionController::TestCase
  setup do
    @home_page_content = home_page_contents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:home_page_contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create home_page_content" do
    assert_difference('HomePageContent.count') do
      post :create, home_page_content: { content: @home_page_content.content }
    end

    assert_redirected_to home_page_content_path(assigns(:home_page_content))
  end

  test "should show home_page_content" do
    get :show, id: @home_page_content
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @home_page_content
    assert_response :success
  end

  test "should update home_page_content" do
    patch :update, id: @home_page_content, home_page_content: { content: @home_page_content.content }
    assert_redirected_to home_page_content_path(assigns(:home_page_content))
  end

  test "should destroy home_page_content" do
    assert_difference('HomePageContent.count', -1) do
      delete :destroy, id: @home_page_content
    end

    assert_redirected_to home_page_contents_path
  end
end
