class AddUnitColumnToPlanRequests < ActiveRecord::Migration
  def change
    add_column :plan_requests, :unit, :string
  end
end
