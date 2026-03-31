module Rails
  module Metro
    module Packs
      class SoftDeletesPack < FeaturePack
        pack_name "soft_deletes"
        description "Discard for soft deletes (archive instead of destroy)"
        category "data"

        def gems
          [
            {name: "discard", version: "~> 1.3"}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "Discard: Add `include Discard::Model` to models",
            "Discard: Add `discarded_at:datetime` column via migration",
            "Discard: Use `record.discard` instead of `record.destroy`",
            "Discard: Query with `User.kept` and `User.discarded`"
          ]
        end
      end
    end
  end
end
