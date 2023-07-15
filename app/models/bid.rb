class Bid < ApplicationRecord
  belongs_to :lot
  belongs_to :user

  validates :value, presence: true
  validate :check_value
  validate :check_dif_value

  def check_value
    return unless lot.min_value > value

    errors.add(:base, "O valor mínimo para esse lote é R$#{lot.min_value}")
    throw(:abort)
  end

  def check_dif_value
    last_bid = Bid.where(lot:).last

    return if last_bid.blank?

    result = value - last_bid.value

    return unless result < last_bid.lot.dif_value

    errors.add(:base, "A diferença de valor para esse lance é de  R$#{lot.dif_value}")
    throw(:abort)
  end
end
