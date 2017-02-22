require 'spec_helper'

wp = 'https://de.wikipedia.org/w/api.php?action=featuredfeed&feed=featured&feedformat=atom'

RSpec.describe BfMultiRss do
  it 'has a version number' do
    expect(BfMultiRss::VERSION).not_to be nil
  end

  it 'fetche_rss wp' do
    BfMultiRss.fetch_rss(wp)
  end

  it 'fetches_all wp' do
    BfMultiRss.fetch_all([wp])
  end

end
