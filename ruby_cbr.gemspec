# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_cbr/version'

Gem::Specification.new do |spec|
  spec.name = 'ruby_cbr'
  spec.version = RubyCbr::VERSION
  spec.authors = ['Manuel Dudda']
  spec.email = ['manuel.dudda@gmail.com']

  spec.summary = %q{CBR system for Ruby and Rails}
  spec.description = %q{Case-based Reasoning for Ruby and for Ruby on Rails}
  spec.homepage = 'https://github.com/manuel84/ruby_cbr'
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://github.com'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/})}
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) {|f| File.basename(f)}
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'levenshtein-ffi', '~> 1.1'
  spec.add_development_dependency 'activesupport', '~> 5.1'
end
