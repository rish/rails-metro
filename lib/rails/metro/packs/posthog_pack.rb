module Rails
  module Metro
    module Packs
      class PosthogPack < FeaturePack
        pack_name "posthog"
        description "PostHog product analytics (server-side + JS snippet)"
        category "analytics"

        def gems
          [
            {name: "posthog-ruby"},
            {name: "posthog-rails"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/posthog.rb", <<~RUBY',
            "  PostHog.init do |config|",
            '    config.api_key = ::Rails.application.credentials.dig(:posthog, :api_key) || ENV["POSTHOG_API_KEY"] || "phc_your_key_here"',
            '    config.host = ::Rails.application.credentials.dig(:posthog, :host) || "https://us.i.posthog.com"',
            '    config.on_error = proc { |status, msg| ::Rails.logger.error("[PostHog] \#{status}: \#{msg}") }',
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "PostHog: Add your API key with `bin/rails credentials:edit`:",
            "  posthog:",
            "    api_key: phc_your_key_here",
            "    host: https://us.i.posthog.com",
            "PostHog: posthog-rails automatically injects the JS snippet into your layout"
          ]
        end
      end
    end
  end
end
