class CreateChatMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_messages do |t|
      t.integer :account_id
      t.string :nickname, index: true
      t.string :text

      t.timestamps
    end
  end
end
