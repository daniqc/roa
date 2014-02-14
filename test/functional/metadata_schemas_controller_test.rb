require 'test_helper'

class MetadataSchemasControllerTest < ActionController::TestCase
  setup do
    @metadata_schema = metadata_schemas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:metadata_schemas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create metadata_schema" do
    assert_difference('MetadataSchema.count') do
      post :create, metadata_schema: { name: @metadata_schema.name }
    end

    assert_redirected_to metadata_schema_path(assigns(:metadata_schema))
  end

  test "should show metadata_schema" do
    get :show, id: @metadata_schema
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @metadata_schema
    assert_response :success
  end

  test "should update metadata_schema" do
    put :update, id: @metadata_schema, metadata_schema: { name: @metadata_schema.name }
    assert_redirected_to metadata_schema_path(assigns(:metadata_schema))
  end

  test "should destroy metadata_schema" do
    assert_difference('MetadataSchema.count', -1) do
      delete :destroy, id: @metadata_schema
    end

    assert_redirected_to metadata_schemas_path
  end
end
