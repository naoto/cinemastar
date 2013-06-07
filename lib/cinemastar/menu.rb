require 'yaml'

module Cinemastar
  class Menu < Hash

    def self.load(path)
      raise Cinemastar::DirectoryNotFoundException unless Dir.exists? path
      @@complete = YAML.load_file("#{File.dirname(__FILE__)}/../../config/complete.yaml") || []
      new(path)
    end

    def initialize(path)
      super
      @root = path.sub(/(.)$/){ 
        $1 == "/" ? $1 : "#{$1}/"
      }
      build
    end

    def build
      Dir.entries(@root).sort.each do |f|
        next if File.file?("#{@root}#{f}") || [".","..","html","bin","thumbnail","module",".ssh"].include?(f)
        self[f] = Menu.new "#{@root}#{f}/"
      end
    end

    def child(owner = "", level = 0, &blk)
      each do |key, val|
        directory = "#{owner}/#{key}"
        blk.call(directory.gsub(/^\//,''), key.gsub(/^\d+_/,'').gsub('_',' '), complete(key), level)
        val.child(directory, level.succ, &blk)
      end
    end

    def complete(key)
      @@complete.include?(key) ? true : false
    end

    def start?(index)
      index == 0
    end

    def last?(index)
      self.length - 1 == index
    end

  end
end
