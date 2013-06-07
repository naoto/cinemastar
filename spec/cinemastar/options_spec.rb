# -*- encoding: utf-8 -*-
require 'spec_helper'
require './lib/cinemastar/options'

describe Cinemastar::Options do

  describe 'load' do
    it 'works' do
      options = ['-p','9999','--directory','/hoge/','-b','0.0.0.0']
      result = Cinemastar::Options.load(options)
      got_key = [:port, :directory, :bind]
      got_val = ['9999','/hoge/','0.0.0.0']
      result.each do |key,val|
       expect(key).to eq got_key.shift
       expect(val).to eq got_val.shift
      end
    end
  end

end
