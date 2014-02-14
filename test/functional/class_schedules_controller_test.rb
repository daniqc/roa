require 'test_helper'

class ClassSchedulesControllerTest < ActionController::TestCase
  setup do
    @class_schedule = class_schedules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:class_schedules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create class_schedule" do
    assert_difference('ClassSchedule.count') do
      post :create, class_schedule: { course_class_id: @class_schedule.course_class_id, schedule_id: @class_schedule.schedule_id }
    end

    assert_redirected_to class_schedule_path(assigns(:class_schedule))
  end

  test "should show class_schedule" do
    get :show, id: @class_schedule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @class_schedule
    assert_response :success
  end

  test "should update class_schedule" do
    put :update, id: @class_schedule, class_schedule: { course_class_id: @class_schedule.course_class_id, schedule_id: @class_schedule.schedule_id }
    assert_redirected_to class_schedule_path(assigns(:class_schedule))
  end

  test "should destroy class_schedule" do
    assert_difference('ClassSchedule.count', -1) do
      delete :destroy, id: @class_schedule
    end

    assert_redirected_to class_schedules_path
  end
end
