App.room = App.cable.subscriptions.create("RoomChannel", {

  connected: function () {},

  disconnected: function () {},

  received: function (data) {
    console.log(data)
    document.location.reload(true)
  },

  speak: function (message, room_id) {
    return this.perform('speak', {message: message, room_id: room_id});
  }
});

document.addEventListener('DOMContentLoaded', function () {
const button = document.getElementById('button')
message_input = document.getElementById('message_input')
room_id = document.getElementById('room_id')
button.addEventListener('click', function () {
  message = message_input.value
  console.log(message)
  room_id = room_id.value
  console.log(room_id)
  App.room.speak(message, room_id);
});
})