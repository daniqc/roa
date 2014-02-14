class AddLearningObjectIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :learning_object_id, :integer
  end
end
