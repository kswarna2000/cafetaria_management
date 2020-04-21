require "active_record"

class Menu < ActiveRecord::Base
  validates :name, presence: true
end
