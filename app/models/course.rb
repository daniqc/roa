class Course < ActiveRecord::Base
	belongs_to :category
	belongs_to :career
	belongs_to :department

	has_many :contents
	has_many :course_classes
	has_many :participants
	has_many :people, :through => :participants
	has_many :learning_materials
	has_many :learning_objects, :through => :learning_materials
	
	attr_accessible :career_id, :category_id, :code, :department_id, :description, :hh_week, :name, :tel_e, :tel_l, :tel_t, :version
	validates :name, presence: true

	scope :topics
	def topics
    	Content.where(:course_id => self.id, :type => "Topic")
  	end
end