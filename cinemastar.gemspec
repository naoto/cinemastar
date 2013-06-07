# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cinemastar/version'

Gem::Specification.new do |gem|
  gem.name          = "cinemastar"
  gem.version       = Cinemastar::VERSION
  gem.authors       = ["Naoto SHINGAKI"]
  gem.email         = ["nao.sora+github@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'foreman'
  gem.add_runtime_dependency 'sinatra'
  gem.add_runtime_dependency 'nokogiri'
  gem.add_runtime_dependency 'json', '~> 1.7.7'

  gem.add_development_dependency 'bundler', '~> 1.3'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'coveralls'

end
