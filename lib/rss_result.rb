module BfMultiRss
  class RssResult
    # remove the public setter interface
    attr_reader :posts, :src

    def initialize(src, posts = [])
      @posts = posts
      @src = src
    end
  end
end
