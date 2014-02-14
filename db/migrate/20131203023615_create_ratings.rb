class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :person_id
      t.integer :learning_object_id
      t.integer :evaluation
      t.string :comment

      t.timestamps
    end
  end
end
