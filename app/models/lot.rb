class Lot < ApplicationRecord
    belongs_to :user
    enum aproved: {'aprovado':true,'não aprovado':false}
end