module Rails
  module Metro
    module Packs
      class PasswordlessPack < FeaturePack
        pack_name "passwordless"
        description "Passwordless for magic-link email authentication"
        category "core"
        conflicts_with "authentication", "devise"

        def gems
          [
            {name: "passwordless"}
          ]
        end

        def template_lines
          [
            'rails_command "generate passwordless:install"'
          ]
        end

        def post_install_notes
          [
            "Passwordless: Run `bin/rails db:migrate` to create session tables",
            "Passwordless: Add `passwordless_with :email` to your User model",
            "Passwordless: Users sign in via emailed magic links -- no passwords"
          ]
        end
      end
    end
  end
end
