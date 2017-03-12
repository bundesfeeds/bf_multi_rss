require 'rss'
require 'http'
require 'parallel'
require 'bf_multi_rss/rss_result'
require 'bf_multi_rss/rss_error'

module BfMultiRss
  class NotInvertibleError < StandardError
  end

  class Fetcher
    attr_reader :concurrency, :errors
    def initialize(concurrency = 4)
      @concurrency = concurrency
      @errors = []
    end

    def fetch_rss(uri)
      response = HTTP.get(uri)
      raise_errors(response, uri)
      rss = RSS::Parser.parse(response.to_s, false)
      if rss.nil?
        err = 'ParseErr ' + uri
        raise NotInvertibleError, err
      end
      rss.items
    end

    def raise_errors(response, uri)
      case response.status
      when 500
        err = 'Http500 ' + uri
        raise NotInvertibleError, err
      when 404
        err = 'Http404 ' + uri
        raise NotInvertibleError, err
      when 301
        err = 'Http301 ' + uri
        raise NotInvertibleError, err
      end
    end

    def fetch_all(uris)
      Parallel.map(
        uris,
        in_processes: @concurrency
      ) do |uri|
        begin
          posts = fetch_rss(uri)
          BfMultiRss::RssResult.new(uri, posts)

        rescue  REXML::ParseException,
                OpenURI::HTTPError,
                Errno::EHOSTUNREACH,
                Errno::ETIMEDOUT,
                RSS::NotWellFormedError,
                Net::OpenTimeout,
                Net::ReadTimeout,
                Errno::ECONNREFUSED,
                Errno::ECONNRESET,
                NotInvertibleError => e
          BfMultiRss::RssError.new(uri, e)
        end
      end
    end
  end
end
