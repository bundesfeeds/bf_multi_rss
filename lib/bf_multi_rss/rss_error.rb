module BfMultiRss
  class RssError
    attr_reader :uri, :e
    def initialize(uri, e)
      @uri = uri
      @e = e
    end
  end
end
