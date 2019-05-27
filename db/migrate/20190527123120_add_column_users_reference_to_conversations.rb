class AddColumnUsersReferenceToConversations < ActiveRecord::Migration[5.2]
  def change
    add_column :conversations, :user_send_id, :integer, index: true
    add_column :conversations, :user_receive_id, :integer, index: true

    add_foreign_key :conversations, :users, column: :user_send_id
    add_foreign_key :conversations, :users, column: :user_receive_id
  end
end
