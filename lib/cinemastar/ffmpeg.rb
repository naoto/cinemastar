#-*- coding: utf-8 -*-

module Cinemastar
  class FFmpeg

    def self.thumbnail(path,category,name)
      ffmpeg = self.new(path.sub(/video/,''), category, name)
      return ffmpeg.image_relative_path if ffmpeg.exists?
      ffmpeg.create_thumbnail
      ffmpeg.image_relative_path
    end

    def self.length(path)
      info = `ffmpeg -i "#{path}" 2>&1`
      info.each_line do |line|
        if line =~ /Duration: (\d{2}):(\d{2}):(\d{2})\.\d{2}/
          return "#{$1}:#{$2}:#{$3}"
        end
      end
    end

    def initialize(path, category, name)
      @movie_path = "#{path}/video"
      @thumbnail_path = "#{path}/thumbnail"
      @path = path
      @category = category
      @name = name
    end

    def create_thumbnail
      `ffmpeg -ss #{[*1..300].sample} -vframes 1 -i "#{movie}" -f image2 -s 160x90 "#{image}"`
    end

    def movie
      "#{@movie_path}/#{@category}/#{@name}"
    end

    def image
      @image ||= "#{@thumbnail_path}/#{"#{@category}/#{@name}".gsub(/[\/\(\)\s\?]/,'_')}.jpg"
    end

    def image_relative_path
      image.sub(@path, '')
    end

    def exists?
      File.exists?(image)
    end

  end
end
