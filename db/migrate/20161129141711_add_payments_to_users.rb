class AddPaymentsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :payments, :integer, :default => 0
  end
end
