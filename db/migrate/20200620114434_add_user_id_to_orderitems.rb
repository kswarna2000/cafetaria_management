class AddUserIdToOrderitems < ActiveRecord::Migration[6.0]
  def change
    add_column :orderitems, :user_id, :integer
  end
end
