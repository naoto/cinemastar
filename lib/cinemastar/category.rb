module Cinemastar
  class Category

    def self.list(path)
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
      @@complate = YAML.load_file("config/complate.yaml")
    end

    def path
      @file.sub(@path, '')
    end

    def name
      @file.sub(/^.+?([^\/]+)$/,'\\1').gsub('_', ' ')
    end

    def complate?
      @@complate.include?(@file.sub(/^.+\/([^\/]+)\/[^\/]+$/,'\\1'))
    end

    def directory?
      File.directory?(@file)
    end

    def to_map
      { 
        path: path,
        name: name,
        complate: complate?.to_s
      }
    end

  end
end

