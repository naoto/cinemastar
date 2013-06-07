# -*- encoding: utf-8 -*-
require 'spec_helper'
require './lib/cinemastar/content'

describe Cinemastar::Content do

  subject {
    root = "#{File.dirname(__FILE__)}/../test/"
    path = "#{root}menu2/test_file1.m4v"

    Cinemastar::Content.new(path, root)
  }

  describe 'latest' do
    it 'list' do
      path = "#{File.dirname(__FILE__)}/../test/"
      range =  0..3
      expect(Cinemastar::Content.latest(path, range).length).to eq 2
    end
  end

  describe 'ignore?' do
    it 'true' do
      filename = "#{File.dirname(__FILE__)}/../test/menu1/test_file3.yaml"
      expect(Cinemastar::Content.ignore?(filename)).to be_true
    end

    it 'false' do
      filename = "#{File.dirname(__FILE__)}/../test/menu3/submenu2/test_file2.m4v"
      expect(Cinemastar::Content.ignore?(filename)).to be_false
    end
  end

  describe 'new' do
    it 'initialize' do
      expect(subject).not_to be_nil
    end
  end

  describe 'title' do
    it 'get name' do
      expect(subject.title).to eq 'menu2: test file1'
    end
  end

  describe 'path' do
    it 'works' do
      expect(subject.path).to eq 'menu2/test_file1.m4v'
    end
  end

  describe 'group_list' do
    it 'works' do
      result = ["menu2: test file1", "submenu2: test file2"]
      subject.group_list() { |cntnt|
        expect(result.include?(cntnt.title)).to be_true
      }
    end
  end

end
