class User < ActiveRecord::Base
	has_secure_password

	belongs_to :person

	attr_accessible :username, :password, :password_confirmation, :person_id, :roles, :roles_mask

	validates_uniqueness_of :username

	ROLES = %w[admin desarrollador visualizador]

	def roles=(roles)
		self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
	end

	def roles
		ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
	end

	def role?(role)
		roles.include? role.to_s
	end

	def role_symbols
		roles.map(&:to_sym)
	end
end
