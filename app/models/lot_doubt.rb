class LotDoubt < ApplicationRecord
  belongs_to :user
  belongs_to :lot

  validates :doubt, presence: true
end
