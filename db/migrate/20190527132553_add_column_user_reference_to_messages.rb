class AddColumnUserReferenceToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :user_send_id, :integer, index: true
    add_foreign_key :messages, :users, column: :user_send_id
  end
end
