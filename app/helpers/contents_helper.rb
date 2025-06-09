require 'uri'
require 'cgi'

module ContentsHelper
  def format_duration(seconds)
    return "00:00:00" if seconds.nil? || seconds < 0
    hours = seconds / 3600
    minutes = (seconds % 3600) / 60
    seconds = seconds % 60
    format("%02d:%02d:%02d", hours, minutes, seconds)
  end

  def youtube_id(url)
    uri  = URI.parse(url)
    host = uri.host&.downcase

    case host
    when /youtu\.be$/
      # https://youtu.be/ID
      uri.path.split('/').last
    when /youtube(-nocookie)?\.com$/
      # https://www.youtube.com/watch?v=ID
      params = CGI.parse(uri.query.to_s)
      params['v']&.first
    else
      nil
    end
  rescue URI::InvalidURIError
    nil
  end

  # Construit l'URL de l'iframe d'embed YouTube avec des params à jour
  # Par défaut : pas de suggestions hors chaîne, branding discret, contrôles visibles
  def youtube_embed_url(url, params = { rel: 0, modestbranding: 1, controls: 1 })
    id = youtube_id(url)
    return unless id

    query = params.map { |k, v| "#{k}=#{v}" }.join('&')
    "https://www.youtube.com/embed/#{id}?#{query}"
  end
end
