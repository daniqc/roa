class Participant < ActiveRecord::Base
	belongs_to :person
	belongs_to :course
	belongs_to :role

	attr_accessible :course_id, :person_id, :role_id

	validates_presence_of :person_id, :role_id, :course_id
end
