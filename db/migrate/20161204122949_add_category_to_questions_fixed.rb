class AddCategoryToQuestionsFixed < ActiveRecord::Migration
  def change
    remove_column :questions, :categoty
    add_column :questions, :category, :string
  end
end
