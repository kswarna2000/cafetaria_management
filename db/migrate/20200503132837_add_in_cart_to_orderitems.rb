class AddInCartToOrderitems < ActiveRecord::Migration[6.0]
  def change
    add_column :orderitems, :in_cart, :boolean
  end
end
