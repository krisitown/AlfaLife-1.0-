class CreateCommentsPoints < ActiveRecord::Migration
  def change
    create_table :comments_points do |t|
      t.integer :comment_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
