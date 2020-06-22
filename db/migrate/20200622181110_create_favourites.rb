class CreateFavourites < ActiveRecord::Migration[6.0]
  def change
    create_table :favourites do |t|
      t.integer "menu_item_id"
      t.string "menu_item_name"
      t.integer "menu_item_quantity"
      t.decimal "menu_item_price"
      t.string "image_url"
      t.integer "user_id"
    end
  end
end
