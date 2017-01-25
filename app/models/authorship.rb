class Authorship < ApplicationRecord
	belongs_to :book
	belong_to :author
end
