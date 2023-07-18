class LotDoubt < ApplicationRecord
  belongs_to :user
  belongs_to :lot

  validates :doubt, presence: true
  has_many :answer_doubts, dependent: :nullify
end
