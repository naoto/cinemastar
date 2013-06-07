# -*- encoding: utf-8 -*-
require 'spec_helper'
require './lib/cinemastar/menu'

describe Cinemastar::Menu do

  subject {
    path = "#{File.dirname(__FILE__)}/../test/"
    menu = Cinemastar::Menu.new(path)
  }

  describe 'load' do
    it 'directory glob files initialize' do
      path = "#{File.dirname(__FILE__)}/../test/"
      result = Cinemastar::Menu.load(path)
      expect(result).not_to be_nil
    end
  end

  describe 'new' do
    it 'initialize' do
      expect(subject).not_to be_nil
    end
  end

  describe 'build' do
    it 'hashed path in to the directory' do
      result = subject.build()
      expect(result.length).to eq 5
    end
  end

  describe 'child' do
    it 'generate menu tree' do
      owner = ""
      level = 0
      got_dir = ["menu1", "menu2", "menu3", "menu3/submenu1","menu3/submenu2"]
      got_key = ["menu1", "menu2", "menu3", "submenu1", "submenu2"]
      got_lv = [0,0,0,1,1]
      subject.child(owner, level) do |dir, key, comp, lv|
        expect(dir).to eq got_dir.shift
        expect(key).to eq got_key.shift
        expect(comp).to be_false
        expect(lv).to eq got_lv.shift
      end
    end
  end

  describe 'complete' do
    it 'works' do
      key = "hoge"
      expect(subject.complete(key)).to be_false
    end
  end

  describe 'start?' do
    it 'list position start' do
      index = 0
      expect(subject.start?(index)).to be_true
    end

    it 'list position not start' do
      index = 1
      expect(subject.start?(index)).to be_false
    end
  end

  describe 'last?' do
    it 'list position last' do
      index = 2
      expect(subject.last?(index)).to be_true
    end
    it 'list position not last' do
      index = 3
      expect(subject.last?(index)).to be_false
    end
  end

end
