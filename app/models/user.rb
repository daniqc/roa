class User < ActiveRecord::Base
	has_secure_password

	belongs_to :person

	attr_accessible :username, :password, :password_confirmation, :person_id

	validates_uniqueness_of :username
end
