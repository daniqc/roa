require 'test_helper'

class LoMetadataSchemasControllerTest < ActionController::TestCase
  setup do
    @lo_metadata_schema = lo_metadata_schemas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lo_metadata_schemas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lo_metadata_schema" do
    assert_difference('LoMetadataSchema.count') do
      post :create, lo_metadata_schema: { learning_object_id: @lo_metadata_schema.learning_object_id, metadata_schema_id: @lo_metadata_schema.metadata_schema_id, value: @lo_metadata_schema.value }
    end

    assert_redirected_to lo_metadata_schema_path(assigns(:lo_metadata_schema))
  end

  test "should show lo_metadata_schema" do
    get :show, id: @lo_metadata_schema
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lo_metadata_schema
    assert_response :success
  end

  test "should update lo_metadata_schema" do
    put :update, id: @lo_metadata_schema, lo_metadata_schema: { learning_object_id: @lo_metadata_schema.learning_object_id, metadata_schema_id: @lo_metadata_schema.metadata_schema_id, value: @lo_metadata_schema.value }
    assert_redirected_to lo_metadata_schema_path(assigns(:lo_metadata_schema))
  end

  test "should destroy lo_metadata_schema" do
    assert_difference('LoMetadataSchema.count', -1) do
      delete :destroy, id: @lo_metadata_schema
    end

    assert_redirected_to lo_metadata_schemas_path
  end
end
