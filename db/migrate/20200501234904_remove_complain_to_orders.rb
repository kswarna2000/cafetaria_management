class RemoveComplainToOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :complain
  end
end
