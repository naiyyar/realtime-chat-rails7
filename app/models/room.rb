class Room < ApplicationRecord
	belongs_to :user
	has_many :messages, dependent: :destroy


	def unread_messages_count
		messages.unread.count
	end
end
