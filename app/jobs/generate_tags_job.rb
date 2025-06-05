class GenerateTagsJob < ApplicationJob
  queue_as :default

  def perform(content)

    TagContentFromAi.new(content).call
    # Do something later
  end
end
