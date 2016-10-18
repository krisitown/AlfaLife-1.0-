class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :content
      t.string :user_id
      t.string :thumbnail

      t.timestamps null: false
    end
  end
end
