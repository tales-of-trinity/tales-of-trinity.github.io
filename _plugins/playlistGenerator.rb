module PlaylistGenerator
  class Generator < Jekyll::Generator
    require 'json'
    require 'open-uri'

    def generate(site)
      playlists = "https://www.googleapis.com/youtube/v3/playlists?part=id&key=" + site.config['youtube_token'] + "&channelId=" + site.config['youtube_channel']
      playlists = JSON.load(open(playlists))

      site.data['videos'] = Array.new

      for playlist in playlists['items']
        playlistItems = "https://www.googleapis.com/youtube/v3/playlistItems?part=contentDetails&key=" + site.config['youtube_token'] + "&channelId="+ site.config['youtube_token'] + "&playlistId=" + playlist['id']
        videos = JSON.load(open(playlistItems))

        first = true
        for video in videos['items']
          if first == true
            first = false
            site.data['videos'] << video['contentDetails']['videoId'] + "?list=" + playlist['id']
          end
        end
      end
    end
  end
end