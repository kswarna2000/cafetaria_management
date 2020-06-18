class AddWalkinCustomerToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :walkin_customer, :boolean
  end
end
