# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mugatu/version"

Gem::Specification.new do |spec|
  spec.name          = "mugatu"
  spec.version       = Mugatu::VERSION
  spec.authors       = ["Zach Ahn"]
  spec.email         = ["zahn@handy.com"]

  spec.summary       = %q(Selectively run linters)
  spec.description   = %q(Mugatu reports linter errors only on changes that you made)
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = %(TODO: Set to "http://mygemserver.com")
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         =
    `git ls-files -z`
      .split("\x0")
      .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rubocop", "~> 0.30"
  spec.add_runtime_dependency "rainbow", ">= 1.99.1", "< 3.0"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry-byebug", "~> 3.3"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "listen", "~> 3.0", "< 3.1"
  spec.add_development_dependency "cocaine", "~> 0.5"
end
