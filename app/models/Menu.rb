require "active_record"

class Menu < ActiveRecord::Base
  validates :name, presence: true

  def self.show_menus(user_id)
    where(user_id: user_id)
  end
  def self.active_menus
    where(is_active: true)
  end
end
