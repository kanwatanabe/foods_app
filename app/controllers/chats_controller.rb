class ChatsController < ApplicationController
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    if user_rooms.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def index
    @rooms = Room.all
    @user = current_user
    @current_user_rooms = current_user.user_rooms

    my_room_ids = []
    @current_user_rooms.each do |user_rooms|
      my_room_ids << user_rooms.room.id
    end
    @another_user_rooms = UserRoom.where(room_id: my_room_ids).where('user_id != ?', @user.id).order(created_at: :desc)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    redirect_to request.referer
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to chats_path(current_user)
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
