class LearningMaterial < ActiveRecord::Base
  belongs_to :content
  belongs_to :learning_object
  belongs_to :course

  attr_accessible :content_id, :learning_object_id, :course_id

  def self.save_content(learning_object,content)
  	create!(:content_id => content.id, :learning_object_id => learning_object.id, :course_id => content.course_id)
  end

  def self.update_contents(learning_object, contents_ids)
  	where(:learning_object_id => learning_object.id).destroy_all

    contents = Content.contents(contents_ids)

  	contents.each do |content|
      save_content(learning_object,content)
    end
  end
end
