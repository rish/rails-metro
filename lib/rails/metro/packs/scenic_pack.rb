module Rails
  module Metro
    module Packs
      class ScenicPack < FeaturePack
        pack_name "scenic"
        description "Scenic for versioned database views"
        category "data"

        def gems
          [
            {name: "scenic"}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "Scenic: Generate views with `bin/rails g scenic:view search_results`",
            "Scenic: Views are versioned -- update with `bin/rails g scenic:view search_results --replace`"
          ]
        end
      end
    end
  end
end
