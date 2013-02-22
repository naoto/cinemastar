require "cinemastar/version"

module Cinemastar

  require 'cinemastar/exception'
  require 'cinemastar/server'
  require 'cinemastar/options'
  require 'cinemastar/menu'
  require 'cinemastar/content'
  
  def self.start(options)
    Server.run!(Options.load(options))
  end

end
