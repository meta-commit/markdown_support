
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "meta_commit_markdown_support/version"

Gem::Specification.new do |spec|
  spec.name          = "meta_commit_markdown_support"
  spec.version       = MetaCommit::Extension::MarkdownSupport::VERSION
  spec.authors       = ["Stanislav Dobrovolskiy"]
  spec.email         = ["uusername@protonmail.ch"]

  spec.summary       = %q{meta_commit extension adds markdown language support}
  spec.homepage      = "https://github.com/meta-commit/markdown_support"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/})}
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "meta_commit_contracts", "~> 0"
  spec.add_runtime_dependency "commonmarker", "~> 0.17"

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug"
end
