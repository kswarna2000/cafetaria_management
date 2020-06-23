class RemoveIsActiveFromMenuitems < ActiveRecord::Migration[6.0]
  def change
    remove_column :menuitems, :is_active, :boolean
  end
end
