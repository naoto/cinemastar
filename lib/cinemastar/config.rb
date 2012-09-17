module Cinemastar
  class Config

    def self.load(file = 'config/setting.yaml')
      raise Error "No Setting File" if !File.exists?(file)
      OpenStruct.new(YAML.load_file(file))
    end

    def self.save(path, value)
      file = File.open(path, 'w+')
      file.write value.to_yaml
      file.close
    end

  end
end
