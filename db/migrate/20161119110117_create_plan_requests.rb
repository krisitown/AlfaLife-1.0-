class CreatePlanRequests < ActiveRecord::Migration
  def change
    create_table :plan_requests do |t|
      t.string :gender
      t.float :weight
      t.float :height
      t.integer :age
      t.string :want_to
      t.text :comments

      t.timestamps null: false
    end
  end
end
