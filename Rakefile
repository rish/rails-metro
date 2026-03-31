require "rake/testtask"
require "standard/rake"
require "shellwords"
require_relative "lib/rails/metro/version"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"].exclude("test/**/tui/**/*_test.rb", "test/integration/**/*_test.rb")
end

Rake::TestTask.new("test:tui") do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/tui/**/*_test.rb"]
end

Rake::TestTask.new("test:integration") do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/integration/**/*_test.rb"]
end

Rake::TestTask.new("test:all") do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task default: %i[test standard]

# ---------------------------------------------------------------------------
# Release tasks
# ---------------------------------------------------------------------------

RELEASE_RELEASE_VERSION_FILE = "lib/rails/metro/version.rb"
RELEASE_RELEASE_CHANGELOG_FILE = "CHANGELOG.md"
RELEASE_RELEASE_PACKAGING_FORMULA = "packaging/homebrew/metro.rb"
RELEASE_RELEASE_PACKAGING_PKGBUILD = "packaging/aur/PKGBUILD"
RELEASE_RELEASE_PACKAGING_SRCINFO = "packaging/aur/.SRCINFO"

namespace :release do
  def current_version
    Rails::Metro::VERSION
  end

  def bump_version(part)
    major, minor, patch = current_version.split(".").map(&:to_i)
    case part.to_sym
    when :major then "#{major + 1}.0.0"
    when :minor then "#{major}.#{minor + 1}.0"
    when :patch then "#{major}.#{minor}.#{patch + 1}"
    else raise "Unknown version part: #{part}. Use major, minor, or patch."
    end
  end

  def write_version(new_version)
    content = File.read(RELEASE_VERSION_FILE)
    updated = content.sub(/VERSION = "[\d.]+"/, %(VERSION = "#{new_version}"))
    File.write(RELEASE_VERSION_FILE, updated)
  end

  def prepend_changelog(new_version)
    today = Time.now.strftime("%Y-%m-%d")
    entry = <<~MD
      ## [#{new_version}] - #{today}

      ### Added
      - TODO: fill in changelog for #{new_version}

    MD
    content = File.read(RELEASE_CHANGELOG_FILE)
    File.write(RELEASE_CHANGELOG_FILE, content.sub("# Changelog\n\n", "# Changelog\n\n#{entry}"))
  end

  def update_packaging_sha(new_version, sha256)
    [RELEASE_PACKAGING_FORMULA, RELEASE_PACKAGING_PKGBUILD].each do |file|
      content = File.read(file)
        .sub(/url "https:\/\/rubygems\.org\/gems\/rails-metro-[\d.]+\.gem"/, %(url "https://rubygems.org/gems/rails-metro-#{new_version}.gem"))
        .sub(/sha256 "[\da-f]+"/, %(sha256 "#{sha256}"))
        .sub(/sha256sums=\('[\da-f]+'\)/, %(sha256sums=('#{sha256}')))
        .sub(/pkgver=[\d.]+/, "pkgver=#{new_version}")
      File.write(file, content)
    end

    srcinfo = File.read(RELEASE_PACKAGING_SRCINFO)
      .sub(/pkgver = [\d.]+/, "pkgver = #{new_version}")
      .sub(/sha256sums = [\da-f]+/, "sha256sums = #{sha256}")
      .sub(%r{source = https://rubygems\.org/downloads/rails-metro-[\d.]+\.gem}, "source = https://rubygems.org/downloads/rails-metro-#{new_version}.gem")
      .sub(/noextract = rails-metro-[\d.]+\.gem/, "noextract = rails-metro-#{new_version}.gem")
    File.write(RELEASE_PACKAGING_SRCINFO, srcinfo)
  end

  desc "Bump version (part: major, minor, patch) — updates version.rb and CHANGELOG"
  task :bump, [:part] do |_, args|
    part = args[:part] || "patch"
    new_version = bump_version(part)
    old_version = current_version

    write_version(new_version)
    prepend_changelog(new_version)

    puts "Bumped #{old_version} → #{new_version}"
    puts "Edit #{RELEASE_CHANGELOG_FILE} to fill in the release notes, then run: rake release:publish"
  end

  desc "Build gem, push to RubyGems, tag, push to GitHub, create release"
  task :publish do
    # Reload version after potential bump
    load RELEASE_VERSION_FILE
    version = Rails::Metro::VERSION
    gem_file = "rails-metro-#{version}.gem"
    tag = "v#{version}"

    # Guard: ensure tests pass
    puts "Running tests..."
    Rake::Task[:test].invoke
    Rake::Task[:standard].invoke

    # Guard: ensure CHANGELOG has a real entry (not the TODO placeholder)
    changelog = File.read(RELEASE_CHANGELOG_FILE)
    if changelog.include?("TODO: fill in changelog for #{version}")
      abort "Changelog for #{version} still has the TODO placeholder. Fill it in first."
    end

    # Guard: ensure tag doesn't already exist
    if system("git tag | grep -q '^#{tag}$'")
      abort "Tag #{tag} already exists. Did you already release this version?"
    end

    # Build
    puts "Building #{gem_file}..."
    sh "gem build rails-metro.gemspec"

    # Get SHA256
    sha256 = `shasum -a 256 #{gem_file}`.split.first
    puts "SHA256: #{sha256}"

    # Update packaging files
    update_packaging_sha(version, sha256)

    # Commit everything
    sh "git add #{RELEASE_VERSION_FILE} #{RELEASE_CHANGELOG_FILE} #{RELEASE_PACKAGING_FORMULA} #{RELEASE_PACKAGING_PKGBUILD} #{RELEASE_PACKAGING_SRCINFO}"
    sh %(git commit -m "Release v#{version}")

    # Tag
    sh "git tag -a #{tag} -m '#{tag}'"

    # Push gem
    puts "Pushing to RubyGems..."
    sh "gem push #{gem_file}"

    # Push to GitHub
    sh "git push origin main"
    sh "git push origin #{tag}"

    # GitHub release — extract changelog section for this version
    notes = changelog.split(/^## \[/).map { |s| "## [#{s}" }.find { |s| s.include?("[#{version}]") }
    notes = notes&.sub(/\A## \[#{Regexp.escape(version)}\][^\n]*\n/, "")&.split(/^## \[/)&.first&.strip || ""

    sh %(gh release create #{tag} --title "#{tag}" --notes #{notes.shellescape})

    puts ""
    puts "Released rails-metro #{version}!"
    puts ""
    puts "Next steps:"
    puts "  Homebrew tap:"
    puts "    cp #{RELEASE_PACKAGING_FORMULA} ~/dev/homebrew-tap/Formula/metro.rb"
    puts "    cd ~/dev/homebrew-tap && git add Formula/metro.rb && git commit -m 'metro #{version}' && git push"
    puts ""
    puts "  AUR:"
    puts "    cp #{RELEASE_PACKAGING_PKGBUILD} ~/dev/aur-rails-metro/PKGBUILD"
    puts "    cp #{RELEASE_PACKAGING_SRCINFO} ~/dev/aur-rails-metro/.SRCINFO"
    puts "    cd ~/dev/aur-rails-metro && git add PKGBUILD .SRCINFO && git commit -m 'Upgrade to #{version}' && git push origin master"
  end
end

desc "Bump and publish in one step — rake release[minor]"
task :release, [:part] do |_, args|
  part = args[:part] || "patch"
  Rake::Task["release:bump"].invoke(part)

  changelog = File.read(RELEASE_CHANGELOG_FILE)
  if changelog.include?("TODO: fill in changelog for")
    puts ""
    puts "Changelog has a TODO placeholder. Edit CHANGELOG.md, then run:"
    puts "  rake release:publish"
  else
    Rake::Task["release:publish"].invoke
  end
end
