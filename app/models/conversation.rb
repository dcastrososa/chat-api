class Conversation < ApplicationRecord
    has_many :messages
    belongs_to :user_receive, class_name: 'User', foreign_key: 'user_receive_id'
    belongs_to :user_send, class_name: 'User', foreign_key: 'user_send_id'

    validates :user_send_id, :user_receive_id, presence: true
end
