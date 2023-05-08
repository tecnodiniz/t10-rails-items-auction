class Lot < ApplicationRecord
    belongs_to :user
    enum aproved: {'aprovado':true,'aguardando aprovação':false}
end