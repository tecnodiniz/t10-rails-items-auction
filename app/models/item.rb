class Item < ApplicationRecord
  belongs_to :category
  before_create :generate_code

  private
  def generate_code 
      self.code = SecureRandom.alphanumeric(20)
  end
end
