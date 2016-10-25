class AddCommentPoints < ActiveRecord::Migration
  def change
     add_column :comments, :points, :integer
  end
end
