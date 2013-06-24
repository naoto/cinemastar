# -*- encoding: utf-8 -*-
require 'spec_helper'
require './lib/cinemastar/page'

describe Cinemastar::Page do

  subject {
    page = 1
    option = {}
    Cinemastar::Page.new(page, option)
  }

  describe 'new' do
    it 'works' do
      expect(subject).not_to be_nil
    end
  end

  describe 'range' do
    it 'works' do
      expect(subject.range()).to eq 0...32
    end
  end

  describe 'paginate' do
    it 'works' do
      result = [0,1,2,3,4]
      subject.paginate() { |page| 
        expect(page).to eq result.shift
      }
      expect(result.length).to eq 0
    end
  end

  describe 'eq' do
    it 'page to true' do
      page = 0
      expect(subject.eq(page)).to be_true
    end

    it 'page to false' do
      page = 1
      expect(subject.eq(page)).to be_false
    end
  end

  describe 'prev' do
    it 'works' do
      expect(subject.prev()).to eq 0
    end
  end

  describe 'next' do
    it 'works' do
      expect(subject.next()).to eq 2
    end
  end

  describe 'last' do
    it 'works' do
      #TODO Mock methods
      expect(subject.last()).to eq 100
    end
  end

  describe 'paginate_end' do
    it 'works' do
      expect(subject.paginate_end()).to eq 5
    end
  end

  describe 'paginate_start' do
    it 'works' do
      expect(subject.paginate_start()).to eq 0
    end
  end

  describe 'now' do
    it 'works' do
      expect(subject.now()).to eq 0
    end
  end

end
