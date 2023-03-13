require_relative "lib/copper/version"

Gem::Specification.new do |spec|
  spec.name = "copper"
  spec.version = Copper::VERSION
  spec.authors = ["Berkan Unal"]
  spec.email = ["Berkanunal@gmail.com"]

  spec.summary = "Create small contained rubocop autocorrect commits from your rubocop-todo.yml"
  spec.homepage = "https://github.com/brkn/copper"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/brkn/copper/issues",
    "changelog_uri" => "https://github.com/brkn/copper/releases",
    "source_code_uri" => "https://github.com/brkn/copper",
    "homepage_uri" => spec.homepage,
    "rubygems_mfa_required" => "true"
  }

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob(%w[LICENSE.txt README.md {exe,lib}/**/*]).reject { |f| File.directory?(f) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
