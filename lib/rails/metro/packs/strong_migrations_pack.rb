module Rails
  module Metro
    module Packs
      class StrongMigrationsPack < FeaturePack
        pack_name "strong_migrations"
        description "Strong Migrations -- catch unsafe migrations before they run"
        category "data"

        def gems
          [
            {name: "strong_migrations"}
          ]
        end

        def template_lines
          [
            'rails_command "generate strong_migrations:install"'
          ]
        end

        def post_install_notes
          [
            "Strong Migrations: Dangerous migrations will raise errors with safe alternatives",
            "Strong Migrations: Use `safety_assured { }` to override when you know it's safe"
          ]
        end
      end
    end
  end
end
