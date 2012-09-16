module Cinemastar
  class Category

    def self.list(path)
      @@complete = YAML.load_file("config/complete.yaml")
      Dir.glob("#{path}/**/*").sort.each do |file|
        category = self.new(file, path)
        if category.directory?
          yield category.to_map
        end
      end
    end

    def initialize(file, path)
      @file = file
      @path = path
    end

    def path
      @file.sub(@path, '')
    end

    def name
      real_name.gsub('_', ' ')
    end

    def real_name
      @file.sub(/^.+?([^\/]+)$/,'\\1')
    end

    def complete?
      @@complete.include?(real_name)
    end

    def directory?
      File.directory?(@file)
    end

    def to_map
      { 
        path: path,
        name: name,
        complete: complete?.to_s
      }
    end

  end
end

