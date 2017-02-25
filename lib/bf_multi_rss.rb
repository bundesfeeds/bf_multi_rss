require 'bf_multi_rss/version'
require 'rss'
require 'http'
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
  class Fetcher
    attr_reader :concurrency
    def initialize(concurrency = 4)
      @concurrency = concurrency
    end

    def self.fetch_rss(uri)
      response = HTTP.get(uri)

      if response.status == 500
        err = 'Http500'
        raise err
      end

      if response.status == 404
        err = 'Http404'
        raise err
      end

      if response.status == 301
        err = 'Http301'
        raise err
      end

      rss = RSS::Parser.parse(response.to_s, false)
      rss.items
    end

    def self.fetch_all(uris)
      Parallel.map(
        uris,
        in_processes: @concurrency
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
end
