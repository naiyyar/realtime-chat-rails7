class Message < ApplicationRecord
  belongs_to :room

  scope :unread, -> { where(unread: true)}
end
