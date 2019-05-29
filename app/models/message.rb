class Message < ApplicationRecord
  validates :text, :conversation_id, presence: true
  belongs_to :conversation
  belongs_to :user_send, class_name: 'User', foreign_key: 'user_send_id'
end
