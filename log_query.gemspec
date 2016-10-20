# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'log_query/version'

Gem::Specification.new do |spec|
  spec.name          = "log_query"
  spec.version       = LogQuery::VERSION
  spec.authors       = ["Jasper Lyons"]
  spec.email         = ["jasper.lyons@gmail.com"]

  spec.summary       = %q{The purpose of this gem is to provide a cli utility to parse and analyse log streams over a short period of time.}
  spec.description   = %q{loq_query or lq is a small cli application that, when piped a set of logs will analyse them and provide real time feed back about them to a user.}
  spec.homepage      = "https://github.com/releaseplatform/log_query"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables << 'lq'
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "descriptive_statistics", "~> 2"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
