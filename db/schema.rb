# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140418185749) do

  create_table "careers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "class_schedules", :force => true do |t|
    t.integer  "course_class_id"
    t.integer  "schedule_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "class_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.string   "comment",            :limit => 500
    t.integer  "like"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "ancestry"
    t.integer  "learning_object_id"
    t.integer  "person_id"
  end

  add_index "comments", ["ancestry"], :name => "index_comments_on_ancestry"

  create_table "contents", :force => true do |t|
    t.integer  "course_id"
    t.integer  "number"
    t.string   "name"
    t.decimal  "hours"
    t.decimal  "in_hours"
    t.decimal  "out_hours"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "ancestry"
    t.string   "type"
  end

  add_index "contents", ["ancestry"], :name => "index_contents_on_ancestry"

  create_table "course_classes", :force => true do |t|
    t.integer  "professor_id"
    t.integer  "class_type_id"
    t.integer  "course_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.decimal  "tel_t"
    t.decimal  "tel_e"
    t.decimal  "tel_l"
    t.decimal  "hh_week"
    t.decimal  "version"
    t.text     "description"
    t.integer  "category_id"
    t.integer  "career_id"
    t.integer  "department_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.integer  "organization_id"
    t.string   "identifier"
    t.string   "title"
    t.boolean  "isvisible"
    t.string   "resource_ref_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "learning_materials", :force => true do |t|
    t.integer  "content_id"
    t.integer  "learning_object_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "course_id"
  end

  create_table "learning_objects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "lo_metadata_schemas", :force => true do |t|
    t.integer  "metadata_schema_id"
    t.integer  "learning_object_id"
    t.string   "value"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "metadata_schemas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "ancestry"
  end

  add_index "metadata_schemas", ["ancestry"], :name => "index_metadata_schemas_on_ancestry"

  create_table "organizations", :force => true do |t|
    t.integer  "learning_object_id"
    t.string   "identifier"
    t.string   "title"
    t.string   "structure"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "participants", :force => true do |t|
    t.integer  "course_id"
    t.integer  "role_id"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "person_id"
    t.integer  "learning_object_id"
    t.integer  "evaluation"
    t.string   "comment"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "resource_files", :force => true do |t|
    t.integer  "resource_id"
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "resources", :force => true do |t|
    t.integer  "learning_object_id"
    t.string   "identifier"
    t.string   "principal_resource_ref"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "resource_type"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "schedules", :force => true do |t|
    t.string   "week_day"
    t.string   "start"
    t.string   "finish"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "person_id"
    t.integer  "roles_mask"
  end

end
