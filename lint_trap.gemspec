# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lint_trap/version'

Gem::Specification.new do |spec|
  spec.name          = "lint_trap"
  spec.version       = LintTrap::VERSION
  spec.authors       = ["Allen Madsen"]
  spec.email         = ["blatyo@gmail.com"]
  spec.summary       = %q{Parses the output of various linters.}
  spec.description   = %q{Parses the output of various linters.}
  spec.homepage      = "https://github.com/lintci/lint_trap"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'github-linguist', '~> 4.2'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "pry-byebug"
end
