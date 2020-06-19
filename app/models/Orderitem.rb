require "active_record"

class Orderitem < ActiveRecord::Base
  validates :menu_item_quantity, numericality: { greater_than: 0 }
  def self.in_cart
    where(in_cart: true)
  end
end
