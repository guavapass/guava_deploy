class ChatMessage < ApplicationRecord
  after_commit :push_message

  private

  def push_message
    ChatAllChannel.push_message(self)
  end
end
