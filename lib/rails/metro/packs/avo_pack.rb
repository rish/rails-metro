module Rails
  module Metro
    module Packs
      class AvoPack < FeaturePack
        pack_name "avo"
        description "Avo -- modern, customizable admin panel framework"
        category "admin"
        conflicts_with "administrate", "activeadmin", "madmin"

        def gems
          [
            {name: "avo"}
          ]
        end

        def template_lines
          [
            'rails_command "generate avo:install"'
          ]
        end

        def post_install_notes
          [
            "Avo: Run `bin/rails db:migrate` to create Avo tables",
            "Avo: Access admin at /avo",
            "Avo: Generate resources with `bin/rails g avo:resource User`"
          ]
        end
      end
    end
  end
end
