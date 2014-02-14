class CreateLearningMaterials < ActiveRecord::Migration
  def change
    create_table :learning_materials do |t|
      t.integer :content_id
      t.integer :learning_object_id

      t.timestamps
    end
  end
end
