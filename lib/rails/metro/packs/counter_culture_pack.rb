module Rails
  module Metro
    module Packs
      class CounterCulturePack < FeaturePack
        pack_name "counter_culture"
        description "Counter Culture for turbo-charged counter caches"
        category "data"

        def gems
          [
            {name: "counter_culture"}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "Counter Culture: Add `counter_culture :category` to models",
            "Counter Culture: Supports conditional counters, multi-level, and custom columns",
            "Counter Culture: Fix counts with `Model.counter_culture_fix_counts`"
          ]
        end
      end
    end
  end
end
