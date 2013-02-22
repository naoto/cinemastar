require 'yaml'

module Cinemastar
  class Menu < Hash

    def self.load(path)
      raise Cinemastar::DirectoryNotFoundException unless Dir.exists? path
      @@complete = YAML.load_file("#{File.dirname(__FILE__)}/../../config/complete.yaml")
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

    def child(level, &blk)
      count = 0
      each do |key, val|
        start = start?(count)
        last = last?(count)
        ul, li = [nil, "data-role=\"dropdown\""]
        if level
          ul, li = ["class=\"sub-menu light sidebar-dropdown-menu\"","data-role=\"dropdown\""]
        end
        blk.call(nil, true, false, false, false, ul, li, nil) if start
        blk.call(nil, false, false, true, false, ul, li, nil)
        blk.call(key.gsub(/^\d+_/,'').gsub('_',' '), false, false, false, false, ul, li, complete(key))
        val.child(true, &blk)
        blk.call(nil, false, false, false, true, ul, li, nil)
        blk.call(nil, false, true, false, false, ul, li, nil) if last
        count = count + 1
      end
    end

    def complete(key)
      @@complete.include?(key) ? '' : '-3'
    end

    def start?(index)
      index == 0
    end

    def last?(index)
      self.length - 1 == index
    end

  end
end
