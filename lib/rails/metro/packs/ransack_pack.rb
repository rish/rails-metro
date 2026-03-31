module Rails
  module Metro
    module Packs
      class RansackPack < FeaturePack
        pack_name "ransack"
        description "Ransack for object-based search and filter forms"
        category "ui"

        def gems
          [
            {name: "ransack", version: "~> 4.0"}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "Ransack: Use `@q = User.ransack(params[:q])` in controllers",
            "Ransack: Build forms with `search_form_for @q do |f|` in views",
            "Ransack: Supports sorting, predicates (_cont, _eq, _gt, etc.)"
          ]
        end
      end
    end
  end
end
