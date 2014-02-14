class CourseClass < ActiveRecord::Base
	belongs_to :course
	belongs_to :class_type
	has_many :class_schedules
	has_many :schedules, :through => :class_schedules

	attr_accessible :class_type_id, :course_id
end
