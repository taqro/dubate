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

// 入力フォームの送信ボタンを押したら発火するように修正する
document.addEventListener("DOMContentLoaded", function(){
  document.getElementById("conversation-btn").addEventListener('click', function(e){
    const conversationText = document.getElementById('conversation-text');
    appRoom.speak(conversationText.value);
    conversationText.value = '';
    e.preventDefault();
  });
}, false);

// window.addEventListener("keypress", function(e) {
//   if (e.key === 'Enter') {
//     appRoom.speak(e.target.value);
//     e.target.value = '';
//     e.preventDefault();
//   }
// })

//議論を離れる直前に行う処理
//明示的に購読を解除する
window.onbeforeunload = function(){
  let subscriptions = consumer.subscriptions['subscriptions'];
  subscriptions.forEach(function(subscription){
    consumer.subscriptions.remove(subscription);
  });
}
