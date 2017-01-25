class CreateAuthorships < ActiveRecord::Migration[5.0]
  def change
    create_table :authorships do |t|
      t.belongs_to :book, index: true
      t.belongs_to :author, index: true
      t.datetime :authorship_date
      t.timestamps null: false
    end
  end
end
