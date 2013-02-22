require 'optparse'

module Cinemastar
  class Options < Hash

    def self.load(options)
      option = new({})
      op = OptionParser.new
      op.on('-p','--port VAL'){ |v| option[:port] = v}
      op.on('-d','--directory VAL'){ |v| option[:directory] = v}
      op.parse!(options)
      option
    end

  end
end

