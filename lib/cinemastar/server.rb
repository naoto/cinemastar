require 'sinatra'
require 'erb'

module Cinemastar
  class Server < Sinatra::Base

    set :root, "#{File.dirname(__FILE__)}/../../"

    get '/' do
      @menu = Menu.load settings.directory
      @latest = Content.latest settings.directory, 0...30
      erb :index
    end

  end
end
