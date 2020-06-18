class AddImageUrlToOrderitems < ActiveRecord::Migration[6.0]
  def change
    add_column :orderitems, :image_url, :string
  end
end
