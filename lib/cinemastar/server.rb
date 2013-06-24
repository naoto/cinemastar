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
      @category = []
      @page = Page.new params[:page]
      @menu = Menu.load settings.directory
      @latest = Content.latest settings.directory, @page.range
      erb :index
    end

    get %r{/content/(.+)$} do
      @category = params[:captures].first.split("/")
      @content = Content.new "#{settings.directory}#{params[:captures].first}", settings.directory
      @menu = Menu.load settings.directory
      erb :content
    end

    get %r{/category/(.+)$} do
      @path = params[:captures].first
      @category = params[:captures].first.split("/")
      @summary = Summary.select @category.last
      @content = Content.new "#{settings.directory}/#{params[:captures].first}/", settings.directory
      @menu = Menu.load settings.directory
      erb :category
    end

    get %r{/summary/(.+)$} do
      @summary = Summary.select params[:captures].first
      erb :summary, :layout => false
    end

  end
end
