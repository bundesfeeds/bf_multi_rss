require 'spec_helper'

wp = 'https://de.wikipedia.org/w/api.php?action=featuredfeed&feed=featured&feedformat=atom'
http500 = 'http://iamfivehundret.com/rss.xml'

RSpec.describe BfMultiRss do
  it 'has a version number' do
    expect(BfMultiRss::VERSION).not_to be nil
  end
  describe 'ok case' do
    it 'fetche_rss wp' do
      BfMultiRss.fetch_rss(wp)
    end
    it 'fetche_rss wp has tems' do
      expect(BfMultiRss.fetch_rss(wp).length).to eq 10
    end
    it 'fetches_all wp' do
      BfMultiRss.fetch_all([wp])
    end
  end
  describe 'errors' do
    it '500' do
      expect { BfMultiRss.fetch_all([http500]) }.to raise_error(RuntimeError)
    end
  end
end
