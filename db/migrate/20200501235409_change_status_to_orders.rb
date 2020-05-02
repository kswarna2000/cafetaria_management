class ChangeStatusToOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :status, :string
  end
end
