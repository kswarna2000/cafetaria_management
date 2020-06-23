require "active_record"

class Order < ActiveRecord::Base
  def self.pending_orders
    where("delivered_at=? and status=?", nil, "inprogress").order(:order_date)
  end
  def self.show_orders(user_id)
    where(user_id: user_id, status: "inprogress").order(:order_date)
  end
  def self.show_history(user_id)
    where(user_id: user_id, status: "completed")
  end
  def self.complaints(user_id)
    where(user_id: user_id, status: "complaint")
  end
  def self.show_complaints
    where(status: "complaint")
  end
  def self.inprogress_orders
    where(delivered_at: nil, status: "inprogress").order(:order_date)
  end
end
