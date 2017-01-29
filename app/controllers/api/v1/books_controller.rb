module Api
	module V1
		class Api::V1::BooksController < Api::V1::BaseController
			before_action :authenticate_user
			before_action :set_user, only: [:show]

			def index
				render :json => Book.all.to_json(:only => [:id,:name,:image], :methods => [:image_url, :book_authors])
			end

			def show
				@book = Book.find(params[:id])
				render :json => @book.to_json(:only => [:id,:name,:image], :methods => [:image_url, :book_authors])
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