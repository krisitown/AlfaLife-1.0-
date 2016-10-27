class AddUpDownToCommentsPoints < ActiveRecord::Migration
  def change
    add_column :comments_points, :vote, :string
  end
end
