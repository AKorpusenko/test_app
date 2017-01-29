module Api
	module V1 
		class Api::V1::UsersController < Api::V1::BaseController
			before_action :authenticate_user
			before_action :set_user, only: [:show]

			def index
				@users = User.all
				render json: @users, each_serializer: UserSerializer
			end

			def show
				Rails.logger.info current_user.inspect
				render json: @user #, serializer: UserSerializer
			end

			private

				def set_user
					@user = User.find(params[:id])
				end

				def user_params
					params.require(:user).permit(:email)
				end
		end
	end
end
