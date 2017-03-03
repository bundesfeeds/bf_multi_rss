require 'spec_helper'

RSpec.describe BfMultiRss::RssResult do
  describe 'create' do
    before(:all) do
      @result = BfMultiRss::RssResult.new('foo', [1, 2])
    end
    it 'name' do
      expect(@result.src).to eq 'foo'
    end

    it 'result' do
      expect(@result.posts).to eq [1, 2]
    end
  end
end
