
lib = File.expand_path('../lib', __FILE__)
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

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'gem-release'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'travis'
  spec.add_development_dependency 'webmock'
  spec.add_dependency 'highline', '~> 1.7'
  spec.add_dependency 'mechanize', '~> 2.7'
  spec.add_dependency 'parallel', '~> 1.6'
  spec.add_dependency 'table_print', '~> 1.5'
  spec.add_dependency 'thor', '~> 0.19'
end
