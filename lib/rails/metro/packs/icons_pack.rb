module Rails
  module Metro
    module Packs
      class IconsPack < FeaturePack
        pack_name "icons"
        description "Lucide Rails for modern SVG icons"
        category "ui"

        def gems
          [
            {name: "lucide-rails"}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "Icons: Use `<%= lucide_icon \"home\" %>` in views",
            "Icons: Browse icons at https://lucide.dev"
          ]
        end
      end
    end
  end
end
