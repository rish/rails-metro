module Rails
  module Metro
    module Packs
      class DevisePack < FeaturePack
        pack_name "devise"
        description "Devise for full-featured authentication (OmniAuth, LDAP, etc.)"
        category "core"
        conflicts_with "authentication", "passwordless"

        def gems
          [
            {name: "devise"}
          ]
        end

        def template_lines
          [
            'rails_command "generate devise:install"',
            'rails_command "generate devise User"'
          ]
        end

        def post_install_notes
          [
            "Devise: Run `bin/rails db:migrate` to create users table",
            "Devise: Generate views with `bin/rails g devise:views`",
            "Devise: Configure mailer sender in config/initializers/devise.rb"
          ]
        end
      end
    end
  end
end
