module Rails
  module Metro
    module Packs
      class KredisPack < FeaturePack
        pack_name "kredis"
        description "Kredis for structured Redis types in Rails models"
        category "data"

        def gems
          [
            {name: "kredis"}
          ]
        end

        def template_lines
          [
            'rails_command "kredis:install"'
          ]
        end

        def post_install_notes
          [
            "Kredis: Requires Redis -- configure in config/redis/shared.yml",
            "Kredis: Use `kredis_list :recent_searches` in models",
            "Kredis: Supports lists, sets, flags, counters, enums, and more"
          ]
        end
      end
    end
  end
end
