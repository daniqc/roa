class CreateResourceFiles < ActiveRecord::Migration
  def change
    create_table :resource_files do |t|
      t.integer :resource_id
      t.string :name

      t.timestamps
    end
  end
end
