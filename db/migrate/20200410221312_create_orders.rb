class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.date :order_date
      t.integer :user_id
    end
  end
end
