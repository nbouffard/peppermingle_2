import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"


// Connects to data-controller="chatroom-subscription"
export default class extends Controller {
  static targets = ["messages"]
  static values = {
    chatroomId: Number
  }
  connect() {
    console.log(`Connecting to the ActionCable channel with id ${this.chatroomIdValue}`)
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: (data) => { this.#insertMessageAndScrollDown(data) } }
    )
  }

  disconnect() {
    console.log("Disconecting from the channel")
    this.channel.unsubscribe()
  }

  resetForm(event) {
    const form = event.target
    form.reset()
  }

  #insertMessageAndScrollDown(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }
}
