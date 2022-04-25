import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {

  // 議論ページ以外では動作しないようにしておく
  const debate_container = document.getElementById('debate-container');
  if (debate_container === null){
    return
  }

  let debate_id = 0;
  if (typeof gon != "undefined"){
    debate_id = gon.debate.id;
  }else{
    return
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
      alert("test");
      // data['conversation']がnullでないとき
      if (data['conversation'] != null ){
        const conversations = document.getElementById('conversations');
      conversations.insertAdjacentHTML('beforeend', data['conversation']);
      } else {
        // 制限時間の処理 (debateのstatusがvotingのとき)
      let status = gon.debate.status;
      if (status == "voting") {
        alert("voting now!");
      }
      }

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

  // 投票開始
  // if (document.getElementById("vote-start-btn") != null){
  //   document.getElementById("vote-start-btn").addEventListener('click', function(e){
  //     alert("投票開始");
  //     e.preventDefault();
  // });
  // }
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



