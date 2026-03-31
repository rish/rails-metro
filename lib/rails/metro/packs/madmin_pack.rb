module Rails
  module Metro
    module Packs
      class MadminPack < FeaturePack
        pack_name "madmin"
        description "Madmin -- a modern admin framework by Chris Oliver (GoRails)"
        category "admin"
        conflicts_with "avo", "administrate", "activeadmin"

        def gems
          [
            {name: "madmin"}
          ]
        end

        def template_lines
          [
            'rails_command "generate madmin:install"'
          ]
        end

        def post_install_notes
          [
            "Madmin: Access admin at /madmin",
            "Madmin: Resources are auto-generated from your models",
            "Madmin: Customize with `bin/rails g madmin:resource User`"
          ]
        end
      end
    end
  end
end
