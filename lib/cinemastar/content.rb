module Cinemastar
  class Content
      
    BASE_PATH = "#{File.dirname(__FILE__)}/../../public/thumbnail/"

    def self.latest(path,range)
      files = []
      Dir.glob("#{path}**/*.*").delete_if{ |d|
        File.directory?(d) || ignore?(d)
      }.sort_by { |file|
        File::stat(file).mtime
      }.reverse[range].each do |file|
        files << Content.new(file, path)
      end
      files
    end

    def self.ignore?(filename)
      case filename
      when /(yaml|yml|jpg|png|gif|html|js|css)$/
        true
      else
        false
      end
    end

    def initialize(path, root)
      @path = path
      @root = root
    end

    def title
      list = @path.split("/")
      filename = list.pop
      category = list.pop

      "#{category.gsub('_', ' ')}: #{filename.gsub(category, '').gsub(/\..+$/,'').gsub('_',' ')}"
    end

    def thumbnail
      filename = "#{@path.gsub(/(\/|_)/,{'/' => '_', '_' => '__'})}.jpg"
      create_thumbnail(@path, filename) if !File.exists?("#{BASE_PATH}#{filename}")
      filename
    end

    def path
      @path.gsub(@root, '').gsub(/^\//,'')
    end

    def group_list
      directory = @path.gsub(/[^\/]+$/, '')
      Dir.entries(directory).sort.each do |content|
        path = "#{directory}#{content}"
        next if [".",".."].include?(content) || File.directory?(path)
        yield Content.new(path, @root)
      end
    end

    private
     def create_thumbnail(path, filename)
       `ffmpeg -ss #{[*1..300].sample} -vframes 1 -i "#{path}" -f image2 -s 320x180 "#{BASE_PATH}#{filename}"`
     end

  end
end
