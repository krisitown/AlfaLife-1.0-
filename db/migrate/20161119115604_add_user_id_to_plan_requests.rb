class AddUserIdToPlanRequests < ActiveRecord::Migration
  def change
    add_column :plan_requests, :user_id, :integer
  end
end
