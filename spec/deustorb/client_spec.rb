require 'spec_helper'

module Deustorb
  describe Client do
    let(:login)         { "#{deusto_server}/login/json/" }
    let(:client)        { Client.new(deusto_server) }
    let(:core_services) { "#{deusto_server}/json/" }
    let(:deusto_server) { 'weblab.deusto.example.com' }

    it "requires a server URL" do
      expect{ Client.new }.to raise_error(ArgumentError)
      expect(client.base_url).to eql(deusto_server)
    end

    describe "#login" do
      context "with valid credentials" do
        before { FakeWeb.register_uri(:post, login, :body => login_response) }
        it "returns the server response credentials" do
          expect(client.login('username', 'password')).to eql(JSON.parse(login_response))
        end

        it "authenticates the user" do
          client.login('user', 'password')
          expect(client).to be_authenticated
        end
      end

      context "with invalid credentials" do
        before { FakeWeb.register_uri(:post, login, :body => failed_login_response) }

        it "does not authenticate the user" do
          client.login('user', 'password')
          expect(client).not_to be_authenticated
        end
      end
    end
  
    describe "#list_experiments" do
      before do
        FakeWeb.register_uri(:post, login, :body => login_response)
        FakeWeb.register_uri(:post, core_services, :body => experiments_list)
        client.login('username', 'password')
      end

      it "returns an array of experiments" do
        expect(client.list_experiments).to eql(JSON.parse(experiments_list))
      end
    end
  end
end