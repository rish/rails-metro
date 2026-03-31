module Rails
  module Metro
    module Packs
      class SparkPack < FeaturePack
        pack_name "spark"
        description "Hotwire Spark — hot reloading for HTML, CSS, and Ruby changes without full page reload"
        category "ops"

        conflicts_with "hotwire_livereload"

        def gems
          [
            {name: "hotwire-spark", group: :development}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "Spark: HTML, CSS, and Ruby file changes are streamed live without full page reload",
            "Spark: No browser extension needed -- works via Turbo Streams over ActionCable"
          ]
        end
      end
    end
  end
end
