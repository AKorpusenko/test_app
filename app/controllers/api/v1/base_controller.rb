module Api
	module V1
		class Api::V1::BaseController < ActionController::API
			include Knock::Authenticable
			undef_method :current_user
		end
	end
end