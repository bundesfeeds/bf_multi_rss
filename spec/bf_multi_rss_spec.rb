require 'spec_helper'

wp = 'https://de.wikipedia.org/w/api.php?action=featuredfeed&feed=featured&feedformat=atom'
http500 = 'http://iamfivehundret.com/rss.xml'
error_empty = 'https://emptycontent.com'

RSpec.describe BfMultiRss do
  it 'has a version number' do
    expect(BfMultiRss::VERSION).not_to be nil
  end

  describe 'constructor' do
    it 'stores the concurrency' do
      bf = BfMultiRss::Fetcher.new(10)
      expect(bf.concurrency).to eq 10
    end
  end

  describe 'ok case' do
    it 'fetche_rss wp' do
      BfMultiRss::Fetcher.fetch_rss(wp)
    end
    it 'fetche_rss wp has tems' do
      expect(BfMultiRss::Fetcher.fetch_rss(wp).length).to eq 10
    end
    it 'fetches_all wp' do
      BfMultiRss::Fetcher.fetch_all([wp])
    end
  end
  describe 'errors' do
    it '500' do
      expect { BfMultiRss::Fetcher.fetch_all([http500]) }.not_to raise_error
    end

    it '200 no content' do
      expect { BfMultiRss::Fetcher.fetch_all([error_empty]) }.not_to raise_error
    end

  end
end
