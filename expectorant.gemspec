# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'expectorant/version'

Gem::Specification.new do |spec|
  spec.name          = "expectorant"
  spec.version       = Expectorant::VERSION
  spec.authors       = ["Kane Baccigalupi"]
  spec.email         = ["baccigalupi@gmail.com"]
  spec.summary       = %q{Sugar DSL for your Test Unit classes: expect(something).to.be(something_else); contexts, lets and more}
  spec.description   = %q{Sugar DSL for your Test Unit classes: expect(something).to.be(something_else); contexts, lets and more}
  spec.homepage      = "http://github.com/baccigalupi/expect"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  # for investigation
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "shoulda"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "gem-open"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "m"
end
