class AddIDsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :article_id, :integer
    add_column :comments, :question_id, :integer
    add_column :comments, :comment_id, :integer
  end
end
