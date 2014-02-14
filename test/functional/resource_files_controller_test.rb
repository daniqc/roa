require 'test_helper'

class ResourceFilesControllerTest < ActionController::TestCase
  setup do
    @resource_file = resource_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resource_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resource_file" do
    assert_difference('ResourceFile.count') do
      post :create, resource_file: { name: @resource_file.name, resource_id: @resource_file.resource_id }
    end

    assert_redirected_to resource_file_path(assigns(:resource_file))
  end

  test "should show resource_file" do
    get :show, id: @resource_file
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @resource_file
    assert_response :success
  end

  test "should update resource_file" do
    put :update, id: @resource_file, resource_file: { name: @resource_file.name, resource_id: @resource_file.resource_id }
    assert_redirected_to resource_file_path(assigns(:resource_file))
  end

  test "should destroy resource_file" do
    assert_difference('ResourceFile.count', -1) do
      delete :destroy, id: @resource_file
    end

    assert_redirected_to resource_files_path
  end
end
