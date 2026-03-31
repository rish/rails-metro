module Rails
  module Metro
    module Packs
      class AdministratePack < FeaturePack
        pack_name "administrate"
        description "Administrate -- Thoughtbot's lightweight admin framework"
        category "admin"
        conflicts_with "avo", "activeadmin", "madmin"

        def gems
          [
            {name: "administrate"}
          ]
        end

        def template_lines
          [
            'rails_command "generate administrate:install"'
          ]
        end

        def post_install_notes
          [
            "Administrate: Access admin at /admin",
            "Administrate: Generate dashboards with `bin/rails g administrate:dashboard User`"
          ]
        end
      end
    end
  end
end
