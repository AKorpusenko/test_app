class BooksController < ApplicationController	
	before_action :authenticate_user!
	before_action :is_admin?
	
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
		au = params[:book]["authors"]
		# puts "HEEHHEHEH" + au.to_s
		if @book.errors.empty?
			# Creating an authorship (connecting authors
			# and the book).
			create_authorships(@book, au.to_s)
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
		au = params[:book]["authors"]
		
		if @book.update_attributes(book_params)
			change_authorships(@book, au.to_s)
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

		def create_authorships(book, authors_str)
			b_id = book.id
			authors = authors_str.split(/\s*,\s*/)
			authors = ["Unknown"] if authors.empty?
			authors.each do |author| 
				if !Author.exists?(name: author)
					Author.create(name: author)
				end
				tmp_author = Author.find_by(name: author)
				Authorship.create(book_id: b_id, author_id: tmp_author.id)
			end
		end

		def change_authorships(book, authors_str)
			b_id = book.id
			new_authors = authors_str.split(/\s*,\s*/)

			old_authors = []

			db_authors = Authorship.where(book_id: b_id)

	    db_authors.each do |a|
	      tmp_author = Author.find_by(id: a.author_id)
	      old_authors << tmp_author.name
	    end

	    new_authors.each do |a|
	    	found = false
	    	old_authors.each do |aa|
	    		if a == aa
	    			found = true
	    			break
	    		end
	    	end
	    	if !found
	    		if !Author.exists?(name: a)
						Author.create(name: a)
					end
					tmp_author = Author.find_by(name: a)
					Authorship.create(book_id: b_id, author_id: tmp_author.id)
	    	end
	    end
		end
end
