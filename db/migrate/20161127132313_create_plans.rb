class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :to_user
      t.text :content
      t.boolean :read

      t.timestamps null: false
    end
  end
end
