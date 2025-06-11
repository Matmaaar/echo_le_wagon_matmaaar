import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("YouTube controller connected")
    this.pollPlayerReady()
  }

  pollPlayerReady() {
    const checkInterval = setInterval(() => {
      if (window.YT && YT.get("youtube-player")) {
        this.player = YT.get("youtube-player")
        console.log("YouTube player is ready ✅")
        clearInterval(checkInterval)
      }
    }, 300)
  }

  captureTime(event) {
    if (!this.player) return
    const seconds = Math.floor(this.player.getCurrentTime())
    const timestamp = this.formatTime(seconds)

    const input = document.querySelector("#note_description") // ou adapte selon ton champ
    input.value = `⏱ ${timestamp} ` + input.value
  }

  formatTime(seconds) {
    const m = Math.floor(seconds / 60).toString().padStart(2, "0")
    const s = (seconds % 60).toString().padStart(2, "0")
    return `${m}:${s}`
  }

  seekTo(event) {
  if (!this.player) return;

  const seconds = parseInt(event.currentTarget.dataset.youtubeSeekTimeValue, 10);
  if (!isNaN(seconds)) {
    this.player.seekTo(seconds, true); // true = start playback
    this.player.playVideo();
  }
}
}

