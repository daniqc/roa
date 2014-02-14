class Category < ActiveRecord::Base
  has_many :courses
  attr_accessible :name, :id
end
