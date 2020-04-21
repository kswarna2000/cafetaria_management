require "active_record"

class Orderitem < ActiveRecord::Base
  validates :menu_item_quantity, numericality: { greater_than: 0 }
end
