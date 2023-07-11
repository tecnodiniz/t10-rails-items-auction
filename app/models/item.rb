class Item < ApplicationRecord
  belongs_to :category
  before_create :generate_code
  validates :name, :weight, :height, :width, :depth, :category_id, presence: true
  validates :code, uniqueness: true

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(20)
  end
end
