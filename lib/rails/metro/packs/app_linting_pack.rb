module Rails
  module Metro
    module Packs
      class AppLintingPack < FeaturePack
        pack_name "app_linting"
        description "Standard Ruby + ERB Lint for code and template linting"
        category "ops"

        def gems
          [
            {name: "standard", group: :development},
            {name: "erb_lint", group: :development}
          ]
        end

        def template_lines
          [
            'create_file ".standard.yml", <<~YML',
            "  # Standard Ruby configuration",
            "  # See: https://github.com/standardrb/standard",
            "YML"
          ]
        end

        def post_install_notes
          [
            "Linting: Run `bundle exec standardrb` to check Ruby code",
            "Linting: Run `bundle exec standardrb --fix` to auto-fix",
            "Linting: Run `bundle exec erblint --lint-all` to check ERB templates"
          ]
        end
      end
    end
  end
end
