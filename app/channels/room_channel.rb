class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'room_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    #  Chat.create!(
    #   user_id: current_user.id,
    #   room_id: data['room_id'],
    #   message: data['message']
    # )
    ActionCable.server.broadcast 'room_channel', message: data['message'], room_id: data['room_id']

    # Chat.create!(chat_params)
  end

  # private

  # def chat_params
  #   params.require(:chat).permit(:message, :room_id)
  # end
end
