class Metro < Formula
  desc "Rails app generator with CLI, TUI, and template output"
  homepage "https://railsmetro.com"
  url "https://rubygems.org/gems/rails-metro-0.3.0.gem"
  sha256 "df9322556c2515cdded93791a6ca60573a9689f65af30f1d89543698224b4472"
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
