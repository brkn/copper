require_relative "lib/autocopper/version"

Gem::Specification.new do |spec|
  spec.name = "autocopper"
  spec.version = Autocopper::VERSION
  spec.authors = ["Berkan Unal"]
  spec.email = ["Berkanunal@gmail.com"]

  spec.summary = ""
  spec.homepage = "https://github.com/brkn/autocopper"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/brkn/autocopper/issues",
    "changelog_uri" => "https://github.com/brkn/autocopper/releases",
    "source_code_uri" => "https://github.com/brkn/autocopper",
    "homepage_uri" => spec.homepage,
    "rubygems_mfa_required" => "true"
  }

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob(%w[LICENSE.txt README.md {exe,lib}/**/*]).reject { |f| File.directory?(f) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
