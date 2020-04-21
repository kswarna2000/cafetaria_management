require "active_record"

class Order < ActiveRecord::Base
  def self.pending_orders
    where(delivered_at: nil).order(:order_date)
  end
end
