require "active_record"

class Menuitem < ActiveRecord::Base
  validates :item_name, presence: true
  validates :item_description, presence: true
  validates :item_price, numericality: { greater_than: 0 }

  def self.show_active_items(menu_id)
    where(menu_id: menu_id).where.not(status: "delete")
  end
end
