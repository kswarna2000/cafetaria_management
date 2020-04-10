class CreateOrderitems < ActiveRecord::Migration[6.0]
  def change
    create_table :orderitems do |t|
      t.integer :order_id
      t.integer :menu_item_id
      t.string :menu_item_name
      t.string :menu_item_price
      t.string :decimal
    end
  end
end
