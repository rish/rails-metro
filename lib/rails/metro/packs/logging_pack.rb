module Rails
  module Metro
    module Packs
      class LoggingPack < FeaturePack
        pack_name "logging"
        description "Lograge for clean, single-line structured request logs"
        category "ops"

        def gems
          [
            {name: "lograge"}
          ]
        end

        def template_lines
          [
            'environment "config.lograge.enabled = true',
            "  config.lograge.custom_payload do |controller|",
            "    {",
            "      host: controller.request.host,",
            "      user_id: controller.respond_to?(:current_user, true) && controller.current_user&.id",
            "    }",
            '  end", env: "production"'
          ]
        end

        def post_install_notes
          [
            "Lograge: Production logs are now single-line structured format",
            "Lograge: Customize payload in config/environments/production.rb"
          ]
        end
      end
    end
  end
end
