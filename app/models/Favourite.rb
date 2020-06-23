class Favourite < ApplicationRecord
  def self.show_favourites(id)
    where(user_id: id)
  end
end
