module Rails
  module Metro
    module Packs
      class DoorkeeperPack < FeaturePack
        pack_name "doorkeeper"
        description "Doorkeeper for OAuth2 provider (issue tokens, authorize apps)"
        category "api"

        def gems
          [
            {name: "doorkeeper"}
          ]
        end

        def template_lines
          [
            'rails_command "generate doorkeeper:install"',
            'rails_command "generate doorkeeper:migration"'
          ]
        end

        def post_install_notes
          [
            "Doorkeeper: Run `bin/rails db:migrate` to create OAuth tables",
            "Doorkeeper: Configure resource owner in config/initializers/doorkeeper.rb",
            "Doorkeeper: Manage OAuth apps at /oauth/applications"
          ]
        end
      end
    end
  end
end
