require "active_record"

class Menuitem < ActiveRecord::Base
  validates :item_name, presence: true
  validates :item_description, presence: true
  validates :item_price, numericality: { greater_than: 0 }
end
