module Rails
  module Metro
    module Packs
      class TaggingPack < FeaturePack
        pack_name "tagging"
        description "Acts As Taggable On for tagging models"
        category "data"

        def gems
          [
            {name: "acts-as-taggable-on", version: "~> 11.0"}
          ]
        end

        def template_lines
          [
            'rails_command "acts_as_taggable_on_engine:install:migrations"'
          ]
        end

        def post_install_notes
          [
            "Tagging: Run `bin/rails db:migrate` to create tag tables",
            "Tagging: Add `acts_as_taggable_on :tags` to models",
            "Tagging: Use `@post.tag_list.add(\"ruby\", \"rails\")`"
          ]
        end
      end
    end
  end
end
