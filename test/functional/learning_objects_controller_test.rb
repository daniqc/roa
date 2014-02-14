require 'test_helper'

class LearningObjectsControllerTest < ActionController::TestCase
  setup do
    @learning_object = learning_objects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:learning_objects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create learning_object" do
    assert_difference('LearningObject.count') do
      post :create, learning_object: { name: @learning_object.name }
    end

    assert_redirected_to learning_object_path(assigns(:learning_object))
  end

  test "should show learning_object" do
    get :show, id: @learning_object
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @learning_object
    assert_response :success
  end

  test "should update learning_object" do
    put :update, id: @learning_object, learning_object: { name: @learning_object.name }
    assert_redirected_to learning_object_path(assigns(:learning_object))
  end

  test "should destroy learning_object" do
    assert_difference('LearningObject.count', -1) do
      delete :destroy, id: @learning_object
    end

    assert_redirected_to learning_objects_path
  end
end
