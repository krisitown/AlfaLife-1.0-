class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text :content
      t.integer :from_id
      t.integer :to_id
      t.boolean :read

      t.timestamps null: false
    end
  end
end
