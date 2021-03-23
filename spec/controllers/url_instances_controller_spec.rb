require 'rails_helper'

RSpec.describe UrlInstancesController, type: :controller do
  let(:valid_url) { "https://someLongHand.com" }
  let(:expected_shorthand) { "someShorthand" }
  before do
    UrlParser.stub(:is_valid_url?).and_return(true)
    UrlParser.stub(:create_shorthand).and_return(expected_shorthand)
  end

  describe "POST /create" do
    context 'with valid URL' do
      it 'stores a UrlInstance if it is considered a valid URL' do
        expect { post :create, params: { url_instance: { input_url: valid_url } } }.to change(UrlInstance, :count).by(1)
      end
    end

    context 'with an invalid URL' do
      let(:invalid_url) { "someInvalidUrl" }
      before do
        UrlParser.stub(:is_valid_url?).and_return(false)
      end

      it 'does not store the url instance' do
        expect { post :create, params: { url_instance: { input_url: invalid_url } } }.to change(UrlInstance, :count).by(0)
      end
      it 'returns an error when an invalid URL is given' do
        post :create, params: { url_instance: { input_url: invalid_url } }
        expect(response).to have_http_status(:bad_request)
      end
    end

    it 'returns an error when we failed to store the URL' do
      #TODO
    end

    it 'returns an error when we fail to create a shorthand' do
      #TODO
    end
  end
end
