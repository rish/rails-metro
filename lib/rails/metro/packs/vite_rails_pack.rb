module Rails
  module Metro
    module Packs
      class ViteRailsPack < FeaturePack
        pack_name "vite_rails"
        description "Vite Rails for fast frontend bundling with HMR"
        category "ui"

        def gems
          [
            {name: "vite_rails"}
          ]
        end

        def template_lines
          [
            'run "bundle exec vite install"'
          ]
        end

        def post_install_notes
          [
            "Vite: Run `bin/vite dev` alongside `bin/rails s` for development",
            "Vite: Hot Module Replacement (HMR) for instant updates",
            "Vite: Build for production with `bin/vite build`"
          ]
        end
      end
    end
  end
end
