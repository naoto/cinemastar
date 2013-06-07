# -*- encoding: utf-8 -*-
require 'spec_helper'
require './lib/cinemastar/server'
require 'rack/test'

set :environment, :test

#@TODO 
describe Cinemastar::Server do

  include Rack::Test::Methods

  def app
    Cinemastar::Server
  end

  describe 'access to /' do
    it 'status' do
      get '/'
      expect(last_response.status).to eq 302
    end

    it 'location' do
      get '/'
      expect(last_response.headers["Location"]).to match(/\/1$/)
    end
  end

end
