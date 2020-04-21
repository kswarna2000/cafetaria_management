class RemoveFieldNameFromTableName < ActiveRecord::Migration[6.0]
  def change
    remove_column :orderitems, :decimal, :string
  end
end
