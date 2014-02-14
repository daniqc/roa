class ChangeTypeColumnFromResources < ActiveRecord::Migration
  def change
  	remove_column :resources, :type
    add_column :resources, :resource_type, :string
  end
end
