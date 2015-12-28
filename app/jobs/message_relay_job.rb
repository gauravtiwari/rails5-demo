class MessageRelayJob < ApplicationJob
  def perform(message)
    ActionCable.server.broadcast "room:#{message.room_id}",
      message: MessagesController.render(partial: 'messages/message', locals: { message: message })
  end
end
