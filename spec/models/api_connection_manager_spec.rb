require 'rails_helper'

RSpec.describe ApiConnectionManager do
  describe "#new(auth_code: Rails.application.credentials.auth_code, url: Rails.application.credentials.api_url)" do
    let(:mock_url) { "https://www.platphormcorp.com/" }
    let(:mock_auth_code) { "It's me, hi, I'm the problem, it's me" }

    before do
      allow(Rails.application.credentials).to receive(:api_url).and_return(mock_url)
      allow(Rails.application.credentials).to receive(:auth_code).and_return(mock_auth_code)
    end

    context "given no kwargs" do
      it "always sets the client to #{described_class::CLIENT_CODE}" do
        instance = ApiConnectionManager.new
        expect(instance.url).to eq(mock_url)
      end

      it "should create a new ApiConnectionManager with default url and auth_code configurations based on our secret credentials" do
        instance = ApiConnectionManager.new
        expect(instance).to be_a(ApiConnectionManager)
        expect(instance.url).to eq(mock_url)
        expect(instance.auth_code).to eq(mock_auth_code)
      end

      context "when the app credentials are not configured" do
        before do
          allow(Rails.application.credentials).to receive(:api_url).and_return(nil)
          allow(Rails.application.credentials).to receive(:auth_code).and_return(nil)
        end

        it "raises an error with helpful troubleshooting messages" do
          expect{ApiConnectionManager.new}.to raise_error(described_class::ConfigurationError, "Kwarg url is not configured, please set the api_url secret credential. Kwarg auth_code is not configured, please set the auth_code secret credential.")
        end
      end
    end

    it "accepts a configurable url argument" do
      configured_url = "https://http.cat/200"
      expect(ApiConnectionManager.new(url: configured_url).url).to eq(configured_url)
    end

    it "accepts a configurable auth_code argument" do
      auth_code = "Bond, James Bond"
      expect(ApiConnectionManager.new(auth_code: auth_code).auth_code).to eq(auth_code)
    end

    it "raises an error with helpful troubleshooting messages when given nil auth_code and url kwargs" do
      expect{ApiConnectionManager.new(auth_code: nil, url: nil)}.to raise_error(described_class::ConfigurationError, "Kwarg url is not configured, please set the api_url secret credential. Kwarg auth_code is not configured, please set the auth_code secret credential.")
    end
  end

  context "given a valid ApiConnectionManager instance" do
    subject(:instance) { ApiConnectionManager.new }

    describe "#base_params" do
      it "returns a hash with keys and values based on the corresponding instance attributes" do
        expect(instance.base_params).to eq({
          client: described_class::CLIENT_CODE,
          auth_code: instance.auth_code,
          phone_number: instance.phone_number,
          message: instance.message
        })
      end
    end

    describe "#configure_connection" do
      it "returns a Faraday::Connection object and memoizes under a @connection attribute" do
        expect(subject.configure_connection).to be_a(Faraday::Connection)
        expect(subject.connection).to be_a(Faraday::Connection)
      end

      it "configures a Faraday::Connection object with the correct url and base_params" do
        connection = subject.configure_connection
        expect(connection.url_prefix.to_s).to eq(subject.url)
        expect(connection.params).to eq(subject.base_params.as_json)
      end
    end

    describe "#set_phone_number" do
      let(:mock_phone_number) { "1234567890" }

      it "sets the phone_number attribute to the given argument and returns it" do
        expect(subject.set_phone_number(mock_phone_number)).to eq(mock_phone_number)
        expect(subject.phone_number).to eq(mock_phone_number)
      end

      it "updates the connection params with the new phone_number" do
        subject.set_phone_number(mock_phone_number)
        expect(subject.connection.params[:phone_number]).to eq(mock_phone_number)
      end
    end
  end
end
