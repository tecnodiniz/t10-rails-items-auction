class UserMessage < ApplicationRecord
  belongs_to :user
  enum status: { unread: 0, read: 1 }, _default: :unread
end
