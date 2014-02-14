require 'test_helper'

class LearningMaterialsControllerTest < ActionController::TestCase
  setup do
    @learning_material = learning_materials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:learning_materials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create learning_material" do
    assert_difference('LearningMaterial.count') do
      post :create, learning_material: { content_id: @learning_material.content_id, learning_object_id: @learning_material.learning_object_id }
    end

    assert_redirected_to learning_material_path(assigns(:learning_material))
  end

  test "should show learning_material" do
    get :show, id: @learning_material
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @learning_material
    assert_response :success
  end

  test "should update learning_material" do
    put :update, id: @learning_material, learning_material: { content_id: @learning_material.content_id, learning_object_id: @learning_material.learning_object_id }
    assert_redirected_to learning_material_path(assigns(:learning_material))
  end

  test "should destroy learning_material" do
    assert_difference('LearningMaterial.count', -1) do
      delete :destroy, id: @learning_material
    end

    assert_redirected_to learning_materials_path
  end
end
