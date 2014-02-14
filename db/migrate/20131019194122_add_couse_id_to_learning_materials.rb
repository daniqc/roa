class AddCouseIdToLearningMaterials < ActiveRecord::Migration
  def change
    add_column :learning_materials, :course_id, :integer
  end
end
