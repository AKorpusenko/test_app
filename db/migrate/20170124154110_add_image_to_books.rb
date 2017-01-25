class AddImageToBooks < ActiveRecord::Migration[5.0]
  def change
  	add_attachment :books, :image
  end
end
