class ContentJob < ApplicationJob
  queue_as :default

  def perform(content)
    content.get_transcript!
    content.summarize!
    TagContentFromAi.new(content).call

  end
end
