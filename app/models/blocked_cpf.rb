class BlockedCpf < ApplicationRecord
  belongs_to :user, optional: true
end
