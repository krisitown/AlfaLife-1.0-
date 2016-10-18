class AddTitleToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :title, :string
    add_column :users, :is_admin, :boolean
  end
end
