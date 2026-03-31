module Rails
  module Metro
    module Packs
      class DotenvPack < FeaturePack
        pack_name "dotenv"
        description "Dotenv for loading .env files in development"
        category "ops"

        def gems
          [
            {name: "dotenv-rails", group: :development}
          ]
        end

        def template_lines
          [
            'create_file ".env.example", <<~ENV',
            "  # Copy to .env and fill in values",
            "  # DATABASE_URL=postgres://localhost/myapp_development",
            "  # RAILS_MASTER_KEY=your_master_key",
            "ENV",
            "",
            'append_to_file ".gitignore", "\\n.env\\n.env.local\\n"'
          ]
        end

        def post_install_notes
          [
            "Dotenv: Copy .env.example to .env and fill in your values",
            "Dotenv: .env files are gitignored -- never commit secrets"
          ]
        end
      end
    end
  end
end
