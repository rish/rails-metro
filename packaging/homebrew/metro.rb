class Metro < Formula
  desc "Rails app generator with CLI, TUI, and template output"
  homepage "https://railsmetro.com"
  url "https://rubygems.org/gems/rails-metro-0.1.0.gem"
  sha256 "44604c7dc34aa9b28db7e4ae8db883593bcc8b7fa4998636d969992dca1a6f16"
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
