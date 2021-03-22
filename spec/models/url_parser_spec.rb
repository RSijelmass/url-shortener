require 'rails_helper'

RSpec.describe UrlParser do
  let(:url_parser) { UrlParser.new }
  context 'create_shorthand_for_url' do
    let(:expected_shorthand) { "abcd1234" }
    before do
      allow(SecureRandom).to receive(:alphanumeric).and_return(expected_shorthand)
    end

    it 'returns a shorthand version for a valid URL' do
      expect(url_parser.create_shorthand).to eq expected_shorthand
    end
  end

  context 'is_valid_url?' do
    let(:valid_url) { "https://www.someExternalUrl.com/someEndpoint" }
    let(:invalid_url_email) { "someExternalEmail@gmail.com" }
    let(:invalid_url_random_string) { "someExternalEmail@gmail.com" }
    let(:invalid_url_trailing_spaces) { valid_url + "   " }

    it 'will tell if we consider the url to be valid' do
      expect(url_parser.is_valid_url? valid_url).to be true
    end
    it 'will tell if we consider the url to be invalid when an email is passed' do
      expect(url_parser.is_valid_url? invalid_url_email).to be false
    end
    it 'will tell if we consider the url to be invalid when a random string is passed' do
      expect(url_parser.is_valid_url? invalid_url_random_string).to be false
    end
    it 'will tell if we consider the url to be invalid when a valid URL with trailing spaces is passed' do
      expect(url_parser.is_valid_url? invalid_url_trailing_spaces).to be false
    end
  end
end
