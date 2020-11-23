import consumer from "./consumer"

$(document).on('turbolinks:load', function() {
  const chatChannel = consumer.subscriptions.create({ channel: 'BoardChannel', board: $('#posts').data('board_id') }, {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received: function(data) {
      return $('#post').append(data['post'])
    },

    speak: function(post) {
      return this.perform('speak', {
        post: post
      })
    }
  })

// data-behaviorがboard_speakerである場所でkeypressすると...
  $(document).on('keypress', '[data-behavior~=board_speaker]', function(event) {
    if (event.keyCode === 13) {
      chatChannel.speak(event.target.value)
      event.target.value = ''
      return event.preventDefault()
    }
  })
})