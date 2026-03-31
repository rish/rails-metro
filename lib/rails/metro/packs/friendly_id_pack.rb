module Rails
  module Metro
    module Packs
      class FriendlyIdPack < FeaturePack
        pack_name "friendly_id"
        description "FriendlyId for human-readable URL slugs"
        category "ui"

        def gems
          [
            {name: "friendly_id", version: "~> 5.5"}
          ]
        end

        def template_lines
          [
            'rails_command "generate friendly_id"'
          ]
        end

        def post_install_notes
          [
            "FriendlyId: Run `bin/rails db:migrate` to create slugs table",
            "FriendlyId: Add `extend FriendlyId` and `friendly_id :name, use: :slugged` to models",
            "FriendlyId: Use `User.friendly.find(\"john-doe\")` instead of `User.find(id)`"
          ]
        end
      end
    end
  end
end
