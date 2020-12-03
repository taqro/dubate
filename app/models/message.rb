class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :content, presence: true
  # after_create_commit { MessageBroadcastJob.perform_later self }

  def template
    ApplicationController.renderer.render partial: 'messages/message', locals: { message: self }
  end

end
