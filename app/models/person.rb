class Person < ActiveRecord::Base
	has_one :user
	has_many :participants
	has_many :courses, :through => :participants
	has_many :comments
	has_many :ratings

	attr_accessible :email, :name, :user_attributes

	accepts_nested_attributes_for :user

	validates_uniqueness_of :email

	validates :email,
			:presence => true,   
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

    def self.new_participants(course)
    	cp = Participant.where(:course_id => course)
    	Person.where('id not in (?)', cp.map(&:person_id))    	
    end
end
