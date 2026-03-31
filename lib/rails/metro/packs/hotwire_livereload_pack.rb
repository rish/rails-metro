module Rails
  module Metro
    module Packs
      class HotwireLivereloadPack < FeaturePack
        pack_name "hotwire_livereload"
        description "Hotwire LiveReload for automatic page refresh on file changes"
        category "ops"

        conflicts_with "spark"

        def gems
          [
            {name: "hotwire-livereload", group: :development}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "LiveReload: Pages auto-refresh when you save views, CSS, or JS files",
            "LiveReload: Works via Hotwire/Turbo -- no browser extension needed"
          ]
        end
      end
    end
  end
end
