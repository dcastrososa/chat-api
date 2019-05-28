class Conversation < ApplicationRecord
    has_many :messages
    belongs_to :user_receive, class_name: 'User', foreign_key: 'user_receive_id'
    belongs_to :user_send, class_name: 'User', foreign_key: 'user_send_id'

    validates :user_send_id, :user_receive_id, presence: true

    def self.get_conversations_user_loggued user_id
        data = Array.new
        conversations = Conversation.where("user_send_id = ? OR user_receive_id = ?", user_id, user_id)

        conversations.each{ |con| 
            conversation = Conversation.parse_conversation_with_user_third(con, user_id)
            data.push(conversation)
        }
        data
    end

    def self.parse_conversation_with_user_third data, user_id
        conversation = Hash.new
        conversation["id"] = data["id"]
        conversation["messages"] = data.messages
        conversation["user_third"] = user_id != data["user_send_id"] ? User.find(data["user_send_id"]) : User.find(data["user_receive_id"])
        return conversation
    end
end
