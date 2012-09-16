module Cinemastar
  class Config

    def self.load(file = 'config/setting.yaml')
      raise Error "No Setting File" if !File.exists?(file)
      OpenStruct.new(YAML.load_file(file))
    end

  end
end
