# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def follow(data)
    stop_all_streams
    stream_from "room:#{data['room_id'].to_i}"
  end

  def unfollow
    stop_all_streams
  end
end
