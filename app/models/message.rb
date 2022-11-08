class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  after_create_commit{broadcast_append_to 'message-box'}

  scope :unread, -> { where(unread: true)}
end
