class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.integer :learning_object_id
      t.string :identifier
      t.string :title
      t.string :structure

      t.timestamps
    end
  end
end
