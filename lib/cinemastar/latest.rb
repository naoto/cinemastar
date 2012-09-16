module Cinemastar
  class Latest

    def self.list(path)
      files = Dir.glob("#{path}/**/*.*").sort_by do |file|
        File::stat(file).mtime
      end
      files = files.reverse[0..30].map do |file|
        video = Video.new(file, path)
        video.to_map
      end
      {files: files}
    end

  end
end

