class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.integer :course_id
      t.integer :number
      t.string :name
      t.decimal :hours
      t.decimal :in_hours
      t.decimal :out_hours

      t.timestamps
    end
  end
end
