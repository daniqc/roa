class ClassType < ActiveRecord::Base
	has_many :course_classes

	attr_accessible :name, :id
end
