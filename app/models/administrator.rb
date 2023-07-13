class Administrator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :lots
  validate :check_email
  validates :cpf, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  


  def check_email
    return unless !self.email.include?('@leilaodogalpao.com.br')

    errors.add(:email, 'email deve conter o domínio @leilaodogalpao.com.br')
  end
end
