module Rails
  module Metro
    module Packs
      class ActiveadminPack < FeaturePack
        pack_name "activeadmin"
        description "ActiveAdmin -- classic, battle-tested admin framework"
        category "admin"
        conflicts_with "avo", "administrate", "madmin"

        def gems
          [
            {name: "activeadmin"}
          ]
        end

        def template_lines
          [
            'rails_command "generate active_admin:install --skip-users"'
          ]
        end

        def post_install_notes
          [
            "ActiveAdmin: Run `bin/rails db:migrate` to create admin tables",
            "ActiveAdmin: Access admin at /admin",
            "ActiveAdmin: Register resources with `bin/rails g active_admin:resource User`"
          ]
        end
      end
    end
  end
end
