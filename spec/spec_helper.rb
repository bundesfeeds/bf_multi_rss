require 'bundler/setup'
require 'bf_multi_rss/fetcher'
require 'bf_multi_rss/rss_error'
require 'webmock/rspec'
wp = 'https://de.wikipedia.org/w/api.php?action=featuredfeed&feed=featured&feedformat=atom'
error_empty = 'https://emptycontent.com'
error500 = 'http://iamfivehundret.com/rss.xml'
error404 = 'http://fourohfour.com/rss.xml'
RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'
  fixture = './spec/fixtures/atom.xml'
  body = File.open(fixture).read

  config.before(:each) do

    stub_request(:get, error500)
    .to_return(status: 500, body: '', headers: {})

    stub_request(:get, wp)
    .to_return(status: 200, body: body, headers: {})

    stub_request(:get, error_empty)
    .to_return(status: 200, body: '', headers: {})

    stub_request(:get, error404)
    .to_return(status: 404, body: '', headers: {})

  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
