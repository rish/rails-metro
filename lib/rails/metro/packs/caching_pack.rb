module Rails
  module Metro
    module Packs
      class CachingPack < FeaturePack
        pack_name "caching"
        description "Solid Cache (Rails 8 default, database-backed caching)"
        category "core"

        def gems
          [
            {name: "solid_cache"}
          ]
        end

        def template_lines
          [
            'rails_command "solid_cache:install"'
          ]
        end

        def post_install_notes
          [
            "Caching: Run `bin/rails db:migrate` to create Solid Cache tables",
            "Caching: Already configured as the default cache store in production"
          ]
        end
      end
    end
  end
end
