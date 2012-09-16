module Cinemastar
  class Latest

    def self.list(path)
      files = []
      Dir.glob("#{path}/**/*.*").sort_by { |file|
        File::stat(file).mtime
      }.reverse.each do |file|
        video = Video.new(file, path)
        files << video.to_map if !video.ignore?
        break if files.size == 30
      end
      {files: files}
    end

  end
end

