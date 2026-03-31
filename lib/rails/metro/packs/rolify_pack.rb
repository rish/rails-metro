module Rails
  module Metro
    module Packs
      class RolifyPack < FeaturePack
        pack_name "rolify"
        description "Rolify for role management (admin, editor, viewer, etc.)"
        category "core"

        def gems
          [
            {name: "rolify"}
          ]
        end

        def template_lines
          [
            'rails_command "generate rolify Role User"'
          ]
        end

        def post_install_notes
          [
            "Rolify: Run `bin/rails db:migrate` to create roles table",
            "Rolify: Assign with `user.add_role :admin`",
            "Rolify: Check with `user.has_role? :admin`",
            "Rolify: Pairs well with Pundit or Action Policy for authorization"
          ]
        end
      end
    end
  end
end
