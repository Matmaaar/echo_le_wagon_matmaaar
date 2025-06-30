class Note < ApplicationRecord
  belongs_to :user
  belongs_to :content


  def video_timestamp_in_seconds
    return nil unless video_timestamp.present?
    parts = video_timestamp.split(':').map(&:to_i)
    case parts.length
    when 3
      hours, minutes, seconds = parts
      hours * 3600 + minutes * 60 + seconds
    when 2
      minutes, seconds = parts
      minutes * 60 + seconds
    else
      nil
    end
  end
end
