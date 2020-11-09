class ChatBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast 'room_channel', message: data['message']
    # ActionCable.server.broadcast 'room_channel', message: render_message
  end

  private

  def render_message(data)
    ApplicationController.renderer.render(partial: 'chats/show', locals: { message: data['message'] })
  end
end
