module Rails
  module Metro
    module Packs
      class ErrorTrackingPack < FeaturePack
        pack_name "sentry"
        description "Sentry for error tracking and performance monitoring"
        category "ops"

        def gems
          [
            {name: "sentry-ruby"},
            {name: "sentry-rails"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/sentry.rb", <<~RUBY',
            "  Sentry.init do |config|",
            '    config.dsn = Rails.application.credentials.dig(:sentry, :dsn) || ENV["SENTRY_DSN"]',
            "    config.breadcrumbs_logger = [:active_support_logger, :http_logger]",
            "    config.traces_sample_rate = 0.1",
            "    config.profiles_sample_rate = 0.1",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Sentry: Add your DSN with `bin/rails credentials:edit`:",
            "  sentry:",
            "    dsn: https://your-dsn@sentry.io/project-id"
          ]
        end
      end
    end
  end
end
