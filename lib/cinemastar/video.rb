module Cinemastar
  class Video
    
    def self.list(directory, path)
      Dir.glob("#{directory}/#{path}/*").sort.each do |file|
        video = self.new(file, directory)
        if video.file? && !video.ignore?
          yield video.to_map
        end
      end
    end

    def self.find_by_name(directory, querys)
      Dir.glob("#{directory}/**/*.*").each do |file|
        if file =~ /(#{querys})/
          yield Video.new(file, directory).to_map
        end
      end
    end

    def initialize(file, path)
      @file = file
      @path = path
      @@infomation ||= Config.load('config/infomation.yaml')
      @@infomation.movie ||= {}
    end

    def path
      @file.sub(@path,'/video')
    end

    def name
      @file.sub(/^.+?([^\/]+?)\.[^\.]+$/,'\\1')
    end

    def thumbnail
     FFmpeg::thumbnail(@path,category,realname)
    end

    def length
      category_and_name = "#{category}/#{realname}"
      if @@infomation.movie[category_and_name].nil?
        @@infomation.movie[category_and_name] = FFmpeg.length(@file)
        Config.save('config/infomation.yaml', @@infomation)
      end

      @@infomation.movie[category_and_name]
    end

    def count
      # TODO
    end

    def category
      @file.sub("#{@path}/",'').gsub(/\/[^\/]+$/,'')
    end

    def realname
      @file.sub(/^.+?([^\/]+?)$/,'\\1')
    end

    def file?
      File.file?(@file)
    end
    
    def ignore?
      return true if /(#{YAML.load_file("config/ignore.yaml").join("|")})$/ =~ @file
    end

    def to_map
      {
        path: path,
        name: name,
        thumbnail: thumbnail,
        length: length,
        count: count
      }
    end

  end
end

