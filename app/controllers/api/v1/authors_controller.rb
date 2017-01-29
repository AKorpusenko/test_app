module Api
	module V1
		class Api::V1::AuthorsController < Api::V1::BaseController

			respond_to :json

			def index
				respond_with Author.all
			end

			def show
				respond_with Author.find(params[:id])
			end
		end
	end
end