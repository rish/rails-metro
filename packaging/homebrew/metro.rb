class Metro < Formula
  desc "Rails app generator with CLI, TUI, and template output"
  homepage "https://railsmetro.com"
  url "https://rubygems.org/gems/rails-metro-0.2.0.gem"
  sha256 "16d925b78500646fb89db4e5b271d4d3feb21477f89bf562eb8cf01f40e0e3a4"
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
