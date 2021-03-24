require 'rails_helper'

RSpec.describe UrlInstancesController, type: :request do
  let(:valid_url) { "https://someLongHand.com" }
  let(:expected_shorthand) { "someShorthand" }
  let(:user) { User.create(id: 1234, username: "someUser") }
  let(:different_user) { User.create(id: 9876, username: "theOtherUser") }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    UrlParser.stub(:is_valid_url?).and_return(true)
    UrlParser.stub(:create_shorthand).and_return(expected_shorthand)
  end

  describe "GET /url_instances" do
    before do
      url_instance_current_user = user.url_instances.new(id:444, longhand: "444444", shorthand: "444").save
      url_instance_other_user = different_user.url_instances.new(id:555, longhand: "5555555", shorthand: "555").save
    end
    it 'returns with a OK response' do
      get '/url_instances'
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /url_instances" do
    context 'with valid URL' do
      it 'stores a UrlInstance if it is considered a valid URL' do
        expect { post '/url_instances', params: { url_instance: { longhand: valid_url } } }.to change(UrlInstance, :count).by(1)
      end
    end

    context 'with an invalid URL' do
      let(:invalid_url) { "someInvalidUrl" }
      before do
        UrlParser.stub(:is_valid_url?).and_return(false)
      end

      it 'does not store the url instance' do
        expect { post '/url_instances', params: { url_instance: { longhand: invalid_url } } }
          .to change(UrlInstance, :count).by(0)
      end
      it 'redirects back to #index with a notice when an invalid URL is given' do
        post '/url_instances', params: { url_instance: { longhand: invalid_url } }

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to url_instances_url
        flash[:notice].should_not be_nil
      end
    end

    it 'redirects back to #index with a notice when we failed to store the URL' do
      UrlInstance.any_instance.stub(:save).and_return(false)
      post '/url_instances', params: { url_instance: { longhand: valid_url } }

      expect(response).to redirect_to url_instances_url
      flash[:notice].should_not be_nil
    end
    it 'redirects back to #index with a notice when we fail to create a shorthand' do
      UrlInstance.any_instance.stub(:save).and_return(false)
      post '/url_instances', params: { url_instance: { longhand: valid_url } }

      expect(response).to redirect_to url_instances_url
      flash[:notice].should_not be_nil
    end
  end

  describe "GET /short/:shorthand" do
    let(:given_shorthand) { "some-shorthand" }
    let(:expected_url) { "https://someExternalUrl.com" }
    let(:url_instance) { user.url_instances.new(longhand: expected_url, shorthand: given_shorthand) }
    before do
      url_instance.save
    end

    it 'redirects and displays the longhand URL if a valid shorthand is given' do
      get "/short/#{given_shorthand}"
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to expected_url
    end
    it 'increases the count on the url instance when fetched' do
      expect do
        get "/short/#{given_shorthand}"
        url_instance.reload
      end.to change(url_instance, :count).from(0).to(1)
    end
    it 'returns a Not Found when the shorthand does not exist' do
      non_existent_shorthand = "some-non-existent-shorthand"
      get "/short/#{non_existent_shorthand}"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "An anonymous user" do
    let(:user) { nil }
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    describe "POST /url_instances" do
      it 'does not store the url instance' do
        expect { post '/url_instances', params: { url_instance: { longhand: valid_url } } }
          .to change(UrlInstance, :count).by(0)
      end
      it 'returns a redirect to home when attempting to create a URL instance' do
        post '/url_instances', params: { url_instance: { longhand: valid_url } }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end
    end

    describe "GET /url_instances" do
      it 'returns a redirect to home when attempting to get URL instances' do
        post '/url_instances', params: { url_instance: { longhand: valid_url } }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end
    end
    describe "GET /short/:shorthand" do
      let(:given_shorthand) { "some-shorthand" }
      let(:expected_url) { "https://someExternalUrl.com" }

      before do
        url_instance = different_user.url_instances.new(longhand: expected_url, shorthand: given_shorthand)
        url_instance.save
      end

      it 'redirects and displays the longhand URL if a valid shorthand is given' do
        get "/short/#{given_shorthand}"
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to expected_url
      end
    end
  end
end
