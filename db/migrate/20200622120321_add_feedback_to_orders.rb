class AddFeedbackToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :feedback, :string
  end
end
