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
  erb :index
end

get '/categorys' do
  @@system.category_list.to_json
end

get %r{/category/#?(.*)} do
  @@system.category_list(params[:captures].first).to_json
end

get '/latest' do
  @@system.latest.to_json
end
