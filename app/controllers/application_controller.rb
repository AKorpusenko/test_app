class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	def after_sign_in_path_for(resource)
		user_root_url
	end

	protected
		def is_admin?
			if current_user.admin?
				true
			else
				redirect_to user_root_url
			end
		end
end

