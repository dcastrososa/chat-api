class ConversationSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :user_receive, class_name: 'User', foreign_key: 'user_receive_id'
  belongs_to :user_send, class_name: 'User', foreign_key: 'user_send_id'
  has_many :messages
end

