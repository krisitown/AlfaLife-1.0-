class AddCategoryToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :categoty, :string
  end
end
