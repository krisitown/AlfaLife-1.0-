class MakeComplexPk < ActiveRecord::Migration
  def change
	add_index :comments_points, ["user_id", "comment_id"], :unique => true
  end
end
