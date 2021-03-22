require 'rails_helper'

RSpec.describe UrlParser do
  let(:url_parser) { UrlParser.new }
  let(:valid_url) { "https://www.someExternalUrl.com/someEndpoint" }
  let(:expected_shorthand) { "abcd1234" }

  before do
    allow(SecureRandom).to receive(:alphanumeric).and_return(expected_shorthand)
  end

  it 'returns a shorthand version for a valid URL' do
    expect(url_parser.create_shorthand_for_url).to eq expected_shorthand
  end
end
