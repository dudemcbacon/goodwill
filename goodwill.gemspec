# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'goodwill/version'

Gem::Specification.new do |spec|
  spec.name          = 'goodwill'
  spec.version       = Goodwill::VERSION
  spec.authors       = ['Brandon Burnett']
  spec.email         = ['gentoolicious@gmail.com']
  spec.license       = 'MIT'

  spec.summary       = 'Basic auction management for ShopGoodwil.com'
  spec.description   = 'Allows you to perform basic auction management, bidding, and searching from ruby.'
  spec.homepage      = 'https://github.com/dudemcbacon/goodwill'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'gem-release'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'travis'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  spec.add_dependency 'highline'
  spec.add_dependency 'mechanize'
  spec.add_dependency 'parallel'
  spec.add_dependency 'table_print'
  spec.add_dependency 'thor'
end
