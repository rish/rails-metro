module Rails
  module Metro
    module Packs
      class HoneybadgerPack < FeaturePack
        pack_name "honeybadger"
        description "Honeybadger for error tracking and uptime monitoring"
        category "ops"

        def gems
          [
            {name: "honeybadger"}
          ]
        end

        def template_lines
          [
            'run "bundle exec honeybadger install"',
            'create_file "config/initializers/honeybadger.rb", <<~RUBY',
            "  Honeybadger.configure do |config|",
            '    config.api_key = Rails.application.credentials.dig(:honeybadger, :api_key) || ENV["HONEYBADGER_API_KEY"]',
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Honeybadger: Add your API key with `bin/rails credentials:edit`:",
            "  honeybadger:",
            "    api_key: your_api_key_here"
          ]
        end
      end
    end
  end
end
