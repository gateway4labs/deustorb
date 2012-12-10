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
        before { fake_it(login, login_response) }
        it "returns the server response credentials" do
          expect(client.login('username', 'password')).to eql(JSON.parse(login_response))
        end

        it "authenticates the user" do
          client.login('user', 'password')
          expect(client).to be_authenticated
        end
      end

      context "with invalid credentials" do
        before { fake_it(login, failed_login_response) }

        it "does not authenticate the user" do
          client.login('user', 'password')
          expect(client).not_to be_authenticated
        end
      end
    end
  
    describe "#list_experiments" do
      before do
        fake_it(login, login_response)
        fake_it(core_services, experiments_list)

        # Make it an authorized client
        client.stub(:authenticated?).and_return(true)
        client.stub(:session_id => "session", :cookies => {})
      end

      it "returns an array of experiments" do
        expect(client.list_experiments).to have(JSON.parse(experiments_list)['result'].size).elements
        expect(client.list_experiments.first).to be_a(Deustorb::Experiment)
      end
    end
  end
end