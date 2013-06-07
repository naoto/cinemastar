# -*- encoding: utf-8 -*-
require 'spec_helper'
require './lib/cinemastar/summary'

describe Cinemastar::Summary do

  subject {
    category = "とある科学の超電磁砲"
    Cinemastar::Summary.new(category)
  }

  describe 'select' do
    it 'works' do
      summary = "/content/とある科学の超電磁砲"
      result = Cinemastar::Summary.select(summary)
      expect(result).not_to be_nil
      expect(result.size).to be > 0
    end
  end

  describe 'new' do
    it 'works' do
      expect(subject).not_to be_nil
    end
  end

  describe 'summary' do
    it 'works' do
      expect(subject.summary).not_to be_nil
    end
  end

end
