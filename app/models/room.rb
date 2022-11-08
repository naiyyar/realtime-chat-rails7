class Room < ApplicationRecord
	belongs_to :user
	has_many :messages, dependent: :destroy
	
	validates_uniqueness_of :name

	after_create_commit{broadcast_prepend_to 'rooms'}

	def unread_messages_count
		messages.unread.count
	end
end
