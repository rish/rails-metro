module Rails
  module Metro
    module Packs
      class DatadogPack < FeaturePack
        pack_name "datadog"
        description "Datadog APM for tracing, metrics, and log management"
        category "ops"

        def gems
          [
            {name: "datadog"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/datadog.rb", <<~RUBY',
            "  Datadog.configure do |c|",
            "    c.service = Rails.application.class.module_parent_name.underscore",
            "    c.env = Rails.env",
            "",
            "    c.tracing.instrument :rails",
            "    c.tracing.instrument :http",
            "    c.tracing.instrument :active_record",
            "    c.tracing.instrument :redis if defined?(Redis)",
            "    c.tracing.instrument :sidekiq if defined?(Sidekiq)",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Datadog: Install the Datadog Agent on your server (not a Ruby gem)",
            "Datadog: Set DD_API_KEY and DD_ENV environment variables in production"
          ]
        end
      end
    end
  end
end
