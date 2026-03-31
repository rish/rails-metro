module Rails
  module Metro
    module Packs
      class BlazerPack < FeaturePack
        pack_name "blazer"
        description "SQL analytics dashboards with Blazer"
        category "analytics"

        def gems
          [
            {name: "blazer", version: "~> 3.0"}
          ]
        end

        def template_lines
          [
            generator_lines,
            route_lines,
            auth_initializer_lines
          ].flatten
        end

        def post_install_notes
          [
            "Blazer: Run `bin/rails db:migrate` to create Blazer tables",
            "Blazer: Access dashboards at /blazer",
            "Blazer: For production, set BLAZER_DATABASE_URL to a read-only database connection"
          ]
        end

        private

        def generator_lines
          [
            'rails_command "generate blazer:install"'
          ]
        end

        def route_lines
          [
            'route "mount Blazer::Engine, at: \\"blazer\\""'
          ]
        end

        def auth_initializer_lines
          [
            'create_file "config/initializers/blazer.rb", <<~RUBY',
            "  # Blazer authentication",
            "  # For production, replace with your app's authentication:",
            "  #   authenticate :user, ->(u) { u.admin? } do",
            "  #     mount Blazer::Engine, at: \"blazer\"",
            "  #   end",
            "  #",
            "  # Or set ENV[\"BLAZER_USERNAME\"] and ENV[\"BLAZER_PASSWORD\"] for basic auth",
            "  ENV[\"BLAZER_DATABASE_URL\"] ||= ENV[\"DATABASE_URL\"]",
            "RUBY"
          ]
        end
      end
    end
  end
end
