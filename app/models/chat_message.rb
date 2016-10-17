class ChatMessage < ApplicationRecord
  include MessageText

  validates :text, inclusion: { in: VALID_MESSAGES }
  validates :nickname, inclusion: { in: CHAT_NAMES }

  after_commit :push_message

  def name
    self.nickname
  end

  private

  def push_message
    ChatAllChannel.push_message(self)
  end
end
