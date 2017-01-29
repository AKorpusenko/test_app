class User < ApplicationRecord
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable

	validates :email, presence: true

	alias_method :authenticate, :valid_password?

	def self.from_token_payload(payload)
		self.find payload["sub"]
	end 
end
