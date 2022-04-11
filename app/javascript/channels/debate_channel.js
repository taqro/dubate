import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  let debate_id = 0;
  if (typeof gon != "undefined"){
    debate_id = gon.debate.id;
  }

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


  if (document.getElementById("conversation-btn") != null){
    document.getElementById("conversation-btn").addEventListener('click', function(e){
      const conversationText = document.getElementById('conversation-text');
      appRoom.speak(conversationText.value);
      conversationText.value = '';
      e.preventDefault();
  });
  }
})

//議論を離れる直前に行う処理
//明示的に購読を解除する
document.addEventListener('turbolinks:before-render', () => {
      let subscriptions = consumer.subscriptions['subscriptions'];
      subscriptions.forEach(function(subscription){
        consumer.subscriptions.remove(subscription);
    });
  }
)



