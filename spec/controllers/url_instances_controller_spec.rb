require 'rails_helper'

RSpec.describe UrlInstancesController, type: :controller do
  let(:given_longhand) { "https://someLongHand.com" }
  let(:expected_shorthand) { "someShorthand" }
  describe "POST /create" do
    it 'stores a UrlInstance if it is considered a valid URL' do
      UrlParser.stub(:is_valid_url?).and_return(true)
      UrlParser.stub(:create_shorthand).and_return(expected_shorthand)

      expect { post :create, params: { url_instance: { input_url: given_longhand } } }.to change(UrlInstance, :count).by(1)
    end
    it 'returns an error when no input URL is given' do
      #TODO
    end
    it 'returns an error when an invalid URL is given' do
      #TODO
    end
    it 'returns an error when we failed to store the URL' do
      #TODO
    end
  end
end
