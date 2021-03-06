class MessageSerializer < ActiveModel::Serializer
  attributes :id, :conversation_id, :text, :created_at
  belongs_to :conversation
  belongs_to :user_send, class_name: 'User', foreign_key: 'user_send_id'
end
