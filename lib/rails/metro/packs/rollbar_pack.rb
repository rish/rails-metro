module Rails
  module Metro
    module Packs
      class RollbarPack < FeaturePack
        pack_name "rollbar"
        description "Rollbar for real-time error tracking and debugging"
        category "ops"
        conflicts_with "error_tracking", "honeybadger"

        def gems
          [
            {name: "rollbar"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/rollbar.rb", <<~RUBY',
            "  Rollbar.configure do |config|",
            '    config.access_token = Rails.application.credentials.dig(:rollbar, :access_token) || ENV["ROLLBAR_ACCESS_TOKEN"]',
            "    config.enabled = !Rails.env.test?",
            "    config.environment = Rails.env",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Rollbar: Add your access token with `bin/rails credentials:edit`:",
            "  rollbar:",
            "    access_token: your_token_here"
          ]
        end
      end
    end
  end
end
