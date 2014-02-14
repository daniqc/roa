class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.integer :learning_object_id
      t.string :identifier
      t.string :type
      t.string :principal_resource_ref

      t.timestamps
    end
  end
end
