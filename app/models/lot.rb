class Lot < ApplicationRecord
    belongs_to :user
    enum aproved: {'aprovado':true,'aguardando aprovação':false}
    validates :code, :start_date, :limit_date,:min_value,:dif_value, presence: true
    validates :code, uniqueness: true
end