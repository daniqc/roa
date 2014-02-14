class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :code
      t.string :name
      t.decimal :tel_t
      t.decimal :tel_e
      t.decimal :tel_l
      t.decimal :hh_week
      t.decimal :version
      t.text :description
      t.integer :category_id
      t.integer :career_id
      t.integer :department_id

      t.timestamps
    end
  end
end
