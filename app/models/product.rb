class Product < ApplicationRecord
  has_one_attached :logo
  belongs_to :prod_category
  enum status: { available: 1, selected: 3, sold: 5 }, _default: :available

  before_validation :generate_code
  validates :name, :width, :height, :weight, :depth, :logo, :cod, presence: true
  has_one :lot_item, dependent: :destroy
  has_one :lot, through: :lot_item

  def generate_code
    self.cod = SecureRandom.alphanumeric(20)
  end
end
