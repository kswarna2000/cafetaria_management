require "active_record"

class Order < ActiveRecord::Base
  def self.pending_orders
    where("delivered_at=? and status=?", nil, "inprogress").order(:order_date)
  end
  def self.show_orders
    where(status: "inprogress").order(:order_date)
  end
end
