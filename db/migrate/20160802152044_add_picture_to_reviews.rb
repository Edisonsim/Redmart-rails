class AddPictureToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :picture, :string
  end
end
