class AuthorsController < ApplicationController
	before_action :authenticate_user!
	before_action :is_admin?
	
	def index
		@authors = Author.all
	end

	def new
		@author = Author.new		
	end

	def show
		@author = Author.find(params[:id])
	end

	def create		
		@author = Author.create(author_params)
		if @author.errors.empty?
			redirect_to @author
		else
			render 'new'
		end
	end

	def edit
		@author = Author.find(params[:id])
	end

	def update
		@author = Author.find(params[:id])
		if @author.update_attributes(author_params)
			redirect_to @author
		else
			render :action => 'edit'
		end
	end

	def destroy
		@author = Author.find(params[:id])
		@author.destroy
		redirect_to action: "index"
	end

	def to_param  # overridden
    name
  end

	private
		def author_params
			params.require(:author).permit(:name)
		end

end
