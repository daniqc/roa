class CreateCourseClasses < ActiveRecord::Migration
  def change
    create_table :course_classes do |t|
      t.integer :professor_id
      t.integer :class_type_id
      t.integer :course_id

      t.timestamps
    end
  end
end
