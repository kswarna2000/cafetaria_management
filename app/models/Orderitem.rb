require "active_record"

class Orderitem < ActiveRecord::Base
  validates :menu_item_quantity, numericality: { greater_than: 0 }
  def self.in_cart(user_id)
    where(user_id: user_id, in_cart: true)
  end

  def self.show_order_items(order_id)
    where(order_id: order_id)
  end
end
