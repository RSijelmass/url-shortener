require 'rails_helper'

RSpec.describe UrlParser do
  context 'create_shorthand_for_url' do
    let(:created_random_string) { "abc123" }
    before do
      allow(SecureRandom).to receive(:alphanumeric).and_return(created_random_string)
    end

    it 'returns a shorthand version for a valid URL' do
      expected_shorthand = created_random_string[0...described_class::SHORTHAND_LIMIT]
      expect(UrlParser.create_shorthand).to eq expected_shorthand
    end
  end

  context 'is_valid_url?' do
    let(:valid_url) { "https://www.someExternalUrl.com/someEndpoint" }
    let(:invalid_url_email) { "someExternalEmail@gmail.com" }
    let(:invalid_url_random_string) { "someExternalEmail@gmail.com" }
    let(:invalid_url_trailing_spaces) { valid_url + "   " }
    let(:invalid_url_empty) { "" }

    it 'will consider the valid url to be valid' do
      expect(UrlParser.is_valid_url? valid_url).to be true
    end
    it 'will consider the url to be invalid when an email is passed' do
      expect(UrlParser.is_valid_url? invalid_url_email).to be false
    end
    it 'will consider the url to be invalid when a random string is passed' do
      expect(UrlParser.is_valid_url? invalid_url_random_string).to be false
    end
    it 'will consider the url to be invalid when a valid URL with trailing spaces is passed' do
      expect(UrlParser.is_valid_url? invalid_url_trailing_spaces).to be false
    end
    it 'will consider the url to be invalid when a valid URL with trailing spaces is passed' do
      expect(UrlParser.is_valid_url? invalid_url_trailing_spaces).to be false
    end
    it 'will consider the url to be invalid when an empty URL is passed' do
      expect(UrlParser.is_valid_url? invalid_url_empty).to be false
    end
    it 'will consider the url to be invalid when a nil object is passed' do
      expect(UrlParser.is_valid_url? nil).to be false
    end
  end
end
