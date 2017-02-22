require 'spec_helper'

RSpec.describe RssResult do
  describe 'create' do
    it '2 result' do
      result = RssResult.new('foo', [1, 2])
      expect(result.src).to eq 'foo'
    end
  end
end
