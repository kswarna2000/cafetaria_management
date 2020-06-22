class AddFeedbackToOrderitems < ActiveRecord::Migration[6.0]
  def change
    add_column :orderitems, :feedback, :string
  end
end
