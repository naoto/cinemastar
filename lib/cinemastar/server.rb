require 'sinatra'
require 'erb'

module Cinemastar
  class Server < Sinatra::Base

    include ERB::Util
    
    set :root, "#{File.dirname(__FILE__)}/../../"

    get '/' do
      redirect '/1'
    end

    get '/:page' do
      @page = Page.new params[:page]
      @menu = Menu.load settings.directory
      @latest = Content.latest settings.directory, @page.range
      erb :index
    end

    get %r{/content/(.+)$} do
      @content = Content.new "#{settings.directory}/#{params[:captures].first}", settings.directory
      @menu = Menu.load settings.directory
      erb :content
    end

    get %r{/category/(.+)$} do
      @content = Content.new "#{settings.directory}/#{params[:captures].first}/", settings.directory
      @menu = Menu.load settings.directory
      erb :category
    end

  end
end
