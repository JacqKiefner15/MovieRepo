class AddRatingToReviews < ActiveRecord::Migration[6.0]
  def chang
    add_column :reviews, :rating, :float
  end
end
