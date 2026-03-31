module Rails
  module Metro
    module Packs
      class NewrelicPack < FeaturePack
        pack_name "newrelic"
        description "New Relic APM for performance monitoring and observability"
        category "ops"

        def gems
          [
            {name: "newrelic_rpm"}
          ]
        end

        def template_lines
          [
            'create_file "config/newrelic.yml", <<~YML',
            "  common: &default_settings",
            "    license_key: <%= Rails.application.credentials.dig(:newrelic, :license_key) || ENV[\"NEW_RELIC_LICENSE_KEY\"] %>",
            "    app_name: <%= Rails.application.class.module_parent_name %>",
            "    distributed_tracing:",
            "      enabled: true",
            "    application_logging:",
            "      forwarding:",
            "        enabled: true",
            "",
            "  development:",
            "    <<: *default_settings",
            "    monitor_mode: false",
            "",
            "  test:",
            "    <<: *default_settings",
            "    monitor_mode: false",
            "",
            "  production:",
            "    <<: *default_settings",
            "    monitor_mode: true",
            "YML"
          ]
        end

        def post_install_notes
          [
            "New Relic: Add your license key with `bin/rails credentials:edit`:",
            "  newrelic:",
            "    license_key: your_license_key_here"
          ]
        end
      end
    end
  end
end
