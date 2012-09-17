module Cinemastar
  class System

    def initialize(settings)
      @config = Config.load
      @settings = settings

      make_symbolic_link
    end

    def category_list(category_path = link_path)
      categorys = []
      Category.list(category_path) do |file|
        categorys << file
      end
      files = []
      Video.list(link_path,category_path) do |file|
        files << file
      end
      { categorys: categorys, files: files }
    end

    def latest
      Latest.list link_path
    end

    def search(querys)
      files = []
      Video.find_by_name(link_path, querys.gsub(/\s/,'|')) do |file|
        files << file
      end
      {files: files }
    end

    private
    def link_path
      @movie_directory ||= File.expand_path("#{@settings.public_folder}/video")
    end

    def make_symbolic_link
      delete_symbolic_link
      File.symlink @config.movie_directory, link_path
    end

    def delete_symbolic_link
      File.delete(link_path) if File.symlink?(link_path)
    end

  end
end


