require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  setup do
    @course = courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post :create, course: { career_id: @course.career_id, category_id: @course.category_id, code: @course.code, department_id: @course.department_id, description: @course.description, hh_week: @course.hh_week, name: @course.name, tel_e: @course.tel_e, tel_l: @course.tel_l, tel_t: @course.tel_t, version: @course.version }
    end

    assert_redirected_to course_path(assigns(:course))
  end

  test "should show course" do
    get :show, id: @course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course
    assert_response :success
  end

  test "should update course" do
    put :update, id: @course, course: { career_id: @course.career_id, category_id: @course.category_id, code: @course.code, department_id: @course.department_id, description: @course.description, hh_week: @course.hh_week, name: @course.name, tel_e: @course.tel_e, tel_l: @course.tel_l, tel_t: @course.tel_t, version: @course.version }
    assert_redirected_to course_path(assigns(:course))
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete :destroy, id: @course
    end

    assert_redirected_to courses_path
  end
end
