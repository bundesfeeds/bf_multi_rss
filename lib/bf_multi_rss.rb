require 'bf_multi_rss/version'
require 'rss'
require 'open-uri'
require 'parallel'

class RssResult
  # remove the public setter interface
  attr_reader :posts, :src

  def initialize(src, posts = [])
    @posts = posts
    @src = src
  end
end

module BfMultiRss
  def self.fetch_rss(uri)
    open(uri) do |rss|
      feed = RSS::Parser.parse(rss, false)
      return feed.items
    end
  end

  def self.fetch_all(uris)
    Parallel.map(
      uris,
      in_processes: 8
    ) do |uri|
      begin
        posts = fetch_rss(uri)
        RssResult.new(uri, posts)
      rescue  REXML::ParseException,
              OpenURI::HTTPError,
              Errno::EHOSTUNREACH,
              RSS::NotWellFormedError,
              Net::OpenTimeout,
              Net::ReadTimeout,
              Errno::ECONNREFUSED,
              Errno::ECONNRESET
        next
      end
    end
  end
end
