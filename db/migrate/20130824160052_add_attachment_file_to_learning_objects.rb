class AddAttachmentFileToLearningObjects < ActiveRecord::Migration
  def self.up
    change_table :learning_objects do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :learning_objects, :file
  end
end
