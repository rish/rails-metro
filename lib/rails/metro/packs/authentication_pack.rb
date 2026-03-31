module Rails
  module Metro
    module Packs
      class AuthenticationPack < FeaturePack
        pack_name "authentication"
        description "authentication-zero (generates code you own, 2FA, recovery codes)"
        category "core"
        conflicts_with "devise", "passwordless"

        def gems
          [
            {name: "authentication-zero"}
          ]
        end

        def template_lines
          [
            'rails_command "generate authentication"'
          ]
        end

        def post_install_notes
          [
            "Authentication: Run `bin/rails db:migrate` to create auth tables",
            "Authentication: See app/controllers/sessions_controller.rb to customize login flow"
          ]
        end
      end
    end
  end
end
