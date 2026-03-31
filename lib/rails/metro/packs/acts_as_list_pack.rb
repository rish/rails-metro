module Rails
  module Metro
    module Packs
      class ActsAsListPack < FeaturePack
        pack_name "acts_as_list"
        description "Acts As List for sortable, orderable records"
        category "data"

        def gems
          [
            {name: "acts_as_list"}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "Acts As List: Add `acts_as_list` to models with a `position` integer column",
            "Acts As List: Use `item.move_to_top`, `item.move_lower`, `item.insert_at(2)`"
          ]
        end
      end
    end
  end
end
