import consumer from "./consumer"

const debate_id = gon.debate.id;

const appRoom = consumer.subscriptions.create({channel: "DebateChannel", debate_id: debate_id}, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const conversations = document.getElementById('conversations');
    conversations.insertAdjacentHTML('beforeend', data['conversation']);
    // return alert(data['conversation']);
  },

  speak: function(conversation) {
    return this.perform('speak', {conversation: conversation, debate_id: debate_id});
  }
});

window.addEventListener("keypress", function(e) {
  if (e.key === 'Enter') {
    appRoom.speak(e.target.value);
    e.target.value = '';
    e.preventDefault();
  }
})
