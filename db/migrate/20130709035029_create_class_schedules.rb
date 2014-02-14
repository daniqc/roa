class CreateClassSchedules < ActiveRecord::Migration
  def change
    create_table :class_schedules do |t|
      t.integer :course_class_id
      t.integer :schedule_id

      t.timestamps
    end
  end
end
