require "bf_multi_rss/version"
require 'rss'
require 'open-uri'


class RssResult
  # remove the public setter interface
  attr_reader :posts, :author

  def initialize(author, posts = [])
    @posts = posts
    @author = author
  end
end

module BfMultiRss
  def self.fetch_rss(uri)
    open(uri) do |rss|
      feed = RSS::Parser.parse(rss, false)
      return feed.items
    end
  end

  def self.fetch_all
    authors = Author.all
    @articles = []
    contents = Parallel.map(
      authors,
      progress: 'Downloading feeds',
      in_processes: 8
    ) do |author|
      begin
        posts = fetch_rss(author.rss)
        RssResult.new(author, posts)
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
    contents
  end
end
