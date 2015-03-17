require File.expand_path('../lib/variables/version', __FILE__)

Gem::Specification.new do |s|
  s.author           = 'Sean Huber'
  s.email            = 'github@shuber.io'
  s.extra_rdoc_files = %w(LICENSE)
  s.files            = `git ls-files`.split("\n")
  s.homepage         = 'https://github.com/shuber/variables'
  s.license          = 'MIT'
  s.name             = 'variables'
  s.rdoc_options     = %w(--charset=UTF-8 --inline-source --line-numbers --main README.md)
  s.require_paths    = %w(lib)
  s.summary          = 'Ruby already has `Method` objects, why not `Variable` objects as well?'
  s.test_files       = `git ls-files -- spec/*`.split("\n")
  s.version          = Variables::VERSION

  s.add_dependency 'abstract_class', '>= 1.0.0'
  s.add_development_dependency 'rspec'
end
