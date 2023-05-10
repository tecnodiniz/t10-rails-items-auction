class Lot < ApplicationRecord
    belongs_to :user

    validates :code, :start_date, :limit_date,:min_value,:dif_value, presence: true
    validates :code, uniqueness: true
    validates :code, length: { is: 9 }, format: { with: /\A[a-zA-Z]{3}\w{6}\z/, message: "deve conter 3 letras e 6 caracteres" }
    # validate :future_date

    enum aproved: {'aprovado':true,'aguardando aprovação':false}

    # def future_date
    #     if start_date  < Date.today
    #       errors.add(:date, "deve ser uma data a partir de hoje")
    #     end
    # end

end