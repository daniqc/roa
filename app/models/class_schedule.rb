class ClassSchedule < ActiveRecord::Base
	belongs_to :schedule
	belongs_to :course_class
	attr_accessible :course_class_id, :schedule_id
end
