class AddMenuItemPriceToOrderitems < ActiveRecord::Migration[6.0]
  def change
    add_column :orderitems, :menu_item_price, :decimal
  end
end
