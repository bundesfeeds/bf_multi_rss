require 'spec_helper'
RSpec.describe BfMultiRss::RssError do

  describe 'properties' do
    let(:err) do
      BfMultiRss::RssError.new('http://foo', Object)
    end
    it 'uri' do
      expect(err.uri).to eq('http://foo')
    end
    it 'e' do
      expect(err.e).to eq(Object)
    end

  end
end
