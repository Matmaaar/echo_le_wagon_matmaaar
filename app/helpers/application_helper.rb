module ApplicationHelper

    def youtube_id(url)
        URI.parse(url).query[/v=([^&]+)/, 1] rescue nil
    end

end
