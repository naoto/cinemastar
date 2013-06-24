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
      @child_category = self
      @selector_path = []
    end

    def build
      Dir.entries(@root).sort.each do |f|
        next if File.file?("#{@root}#{f}") || [".","..","html","bin","thumbnail","module",".ssh"].include?(f)
        self[f] = Menu.new "#{@root}#{f}/"
      end
    end

    def child(owner = nil, &blk)
      if !owner.nil? && @child_category.instance_of?(Hash)
        @selector_path << owner
        puts "#{owner} =======> #{@child_category[owner]}"
        @child_category = @child_category[owner] || @child_category
      end
      @child_category.each do |key, val|
        directory = "#{@selector_path.join("/")}/#{key}"
        path = directory.gsub(/^\//,'')
        name = key.gsub(/^\d+_/,'').gsub('_',' ')
        comp = complete(key)
        blk.call name, path, comp
      end
    end

    def child?(category)
      !@child_category[category].nil? && @child_category[category] != {}
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
