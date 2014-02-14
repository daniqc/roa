class LearningMaterial < ActiveRecord::Base
  belongs_to :content
  belongs_to :learning_object
  belongs_to :course

  attr_accessible :content_id, :learning_object_id, :course_id
end
