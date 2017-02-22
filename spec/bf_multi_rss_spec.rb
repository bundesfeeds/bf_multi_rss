require 'spec_helper'

wp = 'https://de.wikipedia.org/w/api.php?action=featuredfeed&feed=featured&feedformat=atom'

RSpec.describe BfMultiRss do
  it 'has a version number' do
    expect(BfMultiRss::VERSION).not_to be nil
  end

  it 'fetches spiegel' do
    BfMultiRss.fetch_rss(wp)
  end

  it 'fetches spiegel' do
    BfMultiRss.fetch_all([wp])
  end

end
