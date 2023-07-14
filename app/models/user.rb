class User < ApplicationRecord
  validate :cpf_validation

  validates :cpf, :email, :password, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bids, dependent: :destroy

  def cpf_validation
    errors.add(:cpf, 'INVÁLIDO!') unless cpf_valid_p1(cpf) && cpf_valid_p2(cpf)
  end

  def cpf_valid_p1(cpf)
    return false if cpf.nil? || cpf.length != 11

    sum1 = 0
    9.times do |i|
      sum1 += cpf[i].to_i * (10 - i)
    end

    remainder1 = sum1 % 11
    first_digit = remainder1 < 2 ? 0 : 11 - remainder1
    return false if first_digit != cpf[9].to_i

    true
  end

  def cpf_valid_p2(cpf)
    sum2 = 0
    10.times do |i|
      sum2 += cpf[i].to_i * (11 - i)
    end

    remainder2 = sum2 % 11
    second_digit = remainder2 < 2 ? 0 : 11 - remainder2
    return false if second_digit != cpf[10].to_i

    true
  end
end
