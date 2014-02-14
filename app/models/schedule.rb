class Schedule < ActiveRecord::Base
	has_many :class_schedules
	has_many :course_classes, :through => :class_schedules
	attr_accessible :finish, :start, :week_day
end
