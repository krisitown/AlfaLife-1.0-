class AddAnsweredToPlanRequests < ActiveRecord::Migration
  def change
    add_column :plan_requests, :answered, :boolean
  end
end
