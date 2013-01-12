# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cinemastar/version'

Gem::Specification.new do |gem|
  gem.name          = 'cinemastar'
  gem.version       = Cinemastar::VERSION
  gem.authors       = ['Naoto SHINGAKI', 'Tomohiro TAIRA']
  gem.email         = ['tomohiro.t@gmail.com']
  gem.description   = %q{Home video server}
  gem.summary       = %q{Home video server}
  gem.homepage      = 'https://github.com/naoto/cinemastar'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']


  gem.add_runtime_dependency 'sinatra'
  gem.add_runtime_dependency 'thin'
end
