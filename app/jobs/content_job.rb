class ContentJob < ApplicationJob
  queue_as :default

  def perform(content)
    content.get_transcript!
    content.summarize!
    Rails.logger.debug "[ContentJob] summary = #{content.summary.inspect}"

    TagContentFromAi.new(content).call

  end
end
