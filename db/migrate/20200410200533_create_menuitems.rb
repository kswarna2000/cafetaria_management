class CreateMenuitems < ActiveRecord::Migration[6.0]
  def change
    create_table :menuitems do |t|
      t.integer :menu_id
      t.string :item_name
      t.string :item_description
      t.decimal :item_price
    end
  end
end
