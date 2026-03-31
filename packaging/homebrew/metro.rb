class Metro < Formula
  desc "Rails app generator with CLI, TUI, and template output"
  homepage "https://railsmetro.com"
  url "https://rubygems.org/gems/rails-metro-0.1.0.gem"
  sha256 "FILL_IN_AFTER_GEM_PUBLISH"
  license "MIT"

  depends_on "ruby"

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "install", cached_download,
           "--no-document",
           "--install-dir", libexec
    (bin/"metro").write_env_script libexec/"bin/metro", GEM_HOME: libexec
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/metro version")
  end
end
