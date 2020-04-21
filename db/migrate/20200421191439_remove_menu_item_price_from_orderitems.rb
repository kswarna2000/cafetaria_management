class RemoveMenuItemPriceFromOrderitems < ActiveRecord::Migration[6.0]
  def change

    remove_column :orderitems, :menu_item_price, :string
  end
end
