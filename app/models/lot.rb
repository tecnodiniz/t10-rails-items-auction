class Lot < ApplicationRecord
  belongs_to :administrator

  validates :code, :start_date, :limit_date, :min_value, :dif_value, presence: true
  validate :validate_code_format
  validates :start_date, comparison: { greater_than_or_equal_to: Time.zone.today }
  validates :limit_date, comparison: { greater_than_or_equal_to: :start_date }
  has_many :lot_items, dependent: :destroy

  has_many :products, through: :lot_items
  has_many :bids, dependent: :destroy

  enum status: { awaiting: 1, aproved: 3, finished: 5 }

  private

  def validate_code_format
    errors.add(:code, 'deve conter 3 letras e 6 caracteres') unless code_valid?
  end

  def code_valid?
    code.match?(/\A[a-zA-Z]{3}\w{6}\z/)
  end
end
