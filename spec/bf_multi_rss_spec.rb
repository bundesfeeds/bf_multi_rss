require 'spec_helper'

wp = 'https://de.wikipedia.org/w/api.php?action=featuredfeed&feed=featured&feedformat=atom'
http500 = 'http://iamfivehundret.com/rss.xml'
error_empty = 'https://emptycontent.com'
http404 = 'http://fourohfour.com/rss.xml'
RSpec.describe BfMultiRss::Fetcher do

  let(:fetcher) do
    BfMultiRss::Fetcher.new(10)
  end

  describe 'constructor' do
    it 'stores the concurrency' do
      bf = BfMultiRss::Fetcher.new(10)
      expect(bf.concurrency).to eq 10
    end
  end

  describe 'ok case' do
    it 'fetche_rss wp' do
      fetcher.fetch_rss(wp)
    end
    it 'fetche_rss wp has tems' do
      expect(fetcher.fetch_rss(wp).length).to eq 10
    end
    it 'fetches_all wp' do
      fetcher.fetch_all([wp])
    end
  end

  describe '.error' do
    it 'has a .errors property' do
      fetcher = BfMultiRss::Fetcher.new
      expect(fetcher.errors).to be_truthy
    end
    it 'collects errors' do
      fetcher = BfMultiRss::Fetcher.new
      fetcher.fetch_all([http500])
      expect(fetcher.errors.length).to be(1)
    end
  end
  describe 'errors' do
    it '500' do
      expect { fetcher.fetch_all([http500]) }.not_to raise_error
    end

    it '404' do
      expect { fetcher.fetch_all([http404]) }.not_to raise_error
    end

    it '200 no content' do
      expect { fetcher.fetch_all([error_empty]) }.not_to raise_error
    end

  end
end
