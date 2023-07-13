class Product < ApplicationRecord
  has_one_attached :logo
  belongs_to :prod_category
  enum status: { available: 1, selected: 3, sold: 5 }, _default: :available

  before_validation :generate_code
  validates :name, :width, :height, :weight, :depth, :logo, :cod, presence: true
  validates :cod, uniqueness: true

  def generate_code
    self.cod = SecureRandom.alphanumeric(20)
  end

end
