class AddMenuItemQuantityToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :orderitems, :menu_item_quantity, :integer
  end
end
