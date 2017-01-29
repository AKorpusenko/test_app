class Book < ApplicationRecord
	has_many :authorships
	has_many :authors, through: :authorships

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" },
				default_url: "/missing_:style.png"

	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

	def image_url
		image.url(:medium)
	end

	def book_authors
		book = self
		authorships_arr = Authorship.where(book_id: book.id)
		authors_arr = []

		authorships_arr.each do |a|
			tmp_author = Author.find_by(id: a.author_id)
			authors_arr << tmp_author.name
		end

  	authors_arr
  end

end
