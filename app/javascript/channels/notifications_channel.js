import consumer from "./consumer"

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to the Notifications Channel!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    toaster.createAndRender(data["title"], data["message"]);
  }
});

