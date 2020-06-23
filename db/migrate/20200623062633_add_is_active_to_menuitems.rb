class AddIsActiveToMenuitems < ActiveRecord::Migration[6.0]
  def change
    add_column :menuitems, :is_active, :boolean
  end
end
