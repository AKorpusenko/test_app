class BooksController < ApplicationController	
	def index
		@books = Book.all
	end

	def new
		@book = Book.new
	end

	def show
		@book = Book.find(params[:id])
	end

	def create
		@book = Book.create(book_params)
		if @book.errors.empty?
			redirect_to @book
		else
			render 'new'
		end
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update_attributes(book_params)
			redirect_to @book
		else
			render :action => 'edit'
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to action: "index"
	end

	def to_param  # overridden
    name
  end

	private
		def book_params
			params.require(:book).permit(:name, :image)
		end
end
