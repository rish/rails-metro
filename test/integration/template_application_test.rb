require "test_helper"
require "tmpdir"
require "fileutils"

class TemplateApplicationTest < Minitest::Test
  RAILS_BIN = File.join(RbConfig::CONFIG["bindir"], "rails")

  PROFILES = {
    minimal: {
      database: "sqlite3",
      packs: [],
      rails_args: "",
      assert_gems: [],
      assert_files: []
    },
    saas_starter: {
      database: "sqlite3",
      packs: %w[authentication posthog background_jobs],
      rails_args: "",
      assert_gems: %w[authentication-zero posthog-ruby solid_queue],
      assert_files: %w[config/initializers/posthog.rb]
    },
    api_only: {
      database: "sqlite3",
      packs: %w[api_cors api_serialization],
      rails_args: "--api",
      assert_gems: %w[rack-cors alba],
      assert_files: %w[config/initializers/cors.rb config/initializers/alba.rb]
    }
  }.freeze

  PROFILES.each do |profile_name, profile|
    define_method("test_#{profile_name}_profile") do
      Dir.mktmpdir("metro-integration-") do |tmpdir|
        app_name = "test_#{profile_name}_app"
        app_path = File.join(tmpdir, app_name)

        config = Rails::Metro::Config.new(
          app_name: app_name,
          database: profile[:database],
          selected_packs: profile[:packs],
          rails_args: profile[:rails_args]
        )

        registry = Rails::Metro::FeatureRegistry.default
        packs = if config.selected_packs.empty?
          []
        else
          registry.resolve(config.selected_packs)
        end

        compiler = Rails::Metro::TemplateCompiler.new(config: config, packs: packs)
        template_path = compiler.compile_to_file

        rails_cmd = [RAILS_BIN, "new", app_name]
        rails_cmd += ["--database=#{config.database}"] unless config.database == "sqlite3"
        rails_cmd += ["-m", template_path]
        rails_cmd += config.rails_args.split unless config.rails_args.empty?
        rails_cmd += ["--skip-git", "--skip-docker"]

        status = nil
        Bundler.with_unbundled_env do
          pid = spawn(*rails_cmd, chdir: tmpdir, out: File::NULL, err: File::NULL)
          _, status = Process.wait2(pid)
        end

        assert status.success?, "rails new failed for #{profile_name} profile (exit #{status.exitstatus})"
        assert Dir.exist?(app_path), "App directory not created for #{profile_name}"

        gemfile = File.read(File.join(app_path, "Gemfile"))
        profile[:assert_gems].each do |gem_name|
          assert_includes gemfile, gem_name,
            "#{profile_name}: Gemfile missing gem '#{gem_name}'"
        end

        profile[:assert_files].each do |file_path|
          full_path = File.join(app_path, file_path)
          assert File.exist?(full_path),
            "#{profile_name}: Expected file '#{file_path}' not found"
        end

        # Prepare database and verify the app can boot
        Bundler.with_unbundled_env do
          system("bin/rails", "db:prepare", chdir: app_path, out: File::NULL, err: File::NULL)

          output = IO.popen(
            ["bin/rails", "runner", "puts 'OK'", {chdir: app_path}],
            err: [:child, :out]
          ) { |io| io.read }
          runner_status = $?
          assert runner_status.success?,
            "#{profile_name}: bin/rails runner failed (exit #{runner_status.exitstatus})\n#{output}"
        end
      ensure
        File.unlink(template_path) if template_path && File.exist?(template_path)
      end
    end
  end
end
