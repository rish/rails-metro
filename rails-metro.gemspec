require_relative "lib/rails/metro/version"

Gem::Specification.new do |spec|
  spec.name = "rails-metro"
  spec.version = Rails::Metro::VERSION
  spec.authors = ["rails-metro contributors"]
  spec.summary = "Rails app generator with CLI, TUI, and web template output"
  spec.description = "A toggle-driven Rails app generator that produces Rails Application Templates. " \
    "Pick your features (auth, storage, analytics, jobs, etc.) via CLI, TUI, or web UI, " \
    "and get a ready-to-run Rails app."
  spec.homepage = "https://railsmetro.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/rish/rails-metro"
  spec.metadata["changelog_uri"] = "https://github.com/rish/rails-metro/blob/main/CHANGELOG.md"

  spec.files = Dir["lib/**/*", "exe/*", "README.md", "LICENSE", "CHANGELOG.md"]
  spec.bindir = "exe"
  spec.executables = ["metro"]
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 1.3"
end
