module PlaylistGenerator
  class Generator < Jekyll::Generator
    require 'json'
    require 'open-uri'

    def generate(site)
      url = "https://www.googleapis.com/youtube/v3/playlistItems?part=contentDetails&key=XXX&channelId=UCn0PbkRMNmQ-MAFvMWrhc-A&playlistId=PLsyA7GBLQIf5cx-fCtRNZoYQfxnGaW_R3"

      videos = JSON.load(open(url))

      site.data['videos'] = Array.new

      for video in videos['items']
        site.data['videos'] << video['contentDetails']['videoId']
      end
    end
  end
end