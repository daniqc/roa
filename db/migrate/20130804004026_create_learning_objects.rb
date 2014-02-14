class CreateLearningObjects < ActiveRecord::Migration
  def change
    create_table :learning_objects do |t|
      t.string :name

      t.timestamps
    end
  end
end
