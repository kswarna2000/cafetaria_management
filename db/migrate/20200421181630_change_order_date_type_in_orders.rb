class ChangeOrderDateTypeInOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :order_date, :datetime
  end
end
