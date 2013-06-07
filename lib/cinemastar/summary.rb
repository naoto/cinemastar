#-*- coding: utf-8 
require 'nokogiri'
require 'open-uri'
require 'net/http'

module Cinemastar
  class Summary

    def self.select(summary)
      summary = new summary.split("/").last
      summary.summary
    end

    def initialize(category)
      @archive = YAML.load_file("#{File.dirname(__FILE__)}/../../config/summary.yaml") || {}
      @category = category.gsub('_',' ')
      if !@archive.include? category.to_sym
        wiki = wikipedia category
        @archive[category.to_sym] = wiki["あらすじ"] || wiki["ストーリー"] || wiki["概要"]
        save
      end
    end

    def summary
      @archive[@category.to_sym] ||= []
    end

    private
     def save
       o = open('config/summary.yaml','w+')
       o.puts @archive.to_yaml
       o.close
     end

     def wikipedia(category)
       url = URI.escape("http://ja.wikipedia.org/wiki/#{category}")
       subtitle = ""
       content = {}
       Nokogiri::HTML(open(url)).search("#mw-content-text *").each do |tag|
         case tag.name
         when /^h\d$/
           subtitle = tag.content.gsub("[編集]",'').strip
         when /^p$/
           next if tag.content =~ /注意：/
           content[subtitle] ||= []
           content[subtitle] << tag.content.gsub(/\[(注釈|)\d+\]/, '')
         end
       end
       content
     rescue
       return {}
     end

  end
end
