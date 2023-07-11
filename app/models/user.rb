class User < ApplicationRecord
  validates :cpf, cpf: { message: 'CPF inválido' }
  validates :cpf, uniqueness: true
  validates :cpf, :email, :password, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
