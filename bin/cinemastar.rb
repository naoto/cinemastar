#!/usr/bin/env ruby
#-*- coding: utf-8 -*-

$: << './lib'
require 'cinemastar'

require 'rubygems'
require 'sinatra'
require 'erb'
require 'json'

set :root, "#{File.dirname(__FILE__)}/../"

configure do
  @@system = Cinemastar::System.new(settings)
end

get '/' do
  @category = @@system.category_list
  erb :index
end

get '/categorys' do
  @@system.category_list.to_json
end

get '/latest' do
  @@system.latest.to_json
end

get %r{/search/#?(.*)} do
  @@system.search(params[:captures].first).to_json
end

get %r{/#?(.*)} do
  @@system.category_list(params[:captures].first).to_json
end
