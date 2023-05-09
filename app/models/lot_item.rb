class LotItem < ApplicationRecord
  belongs_to :lot
  belongs_to :item

  validates :item_id, presence: true
end
