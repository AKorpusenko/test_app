class UserSerializer < ApplicationSerializer
	attributes :id, :email
	attribute :email, if: :current_user
end
