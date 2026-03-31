module Rails
  module Metro
    module Packs
      class SearchPack < FeaturePack
        pack_name "search"
        description "pg_search for PostgreSQL full-text search"
        category "data"
        conflicts_with "meilisearch", "elasticsearch"

        def gems
          [
            {name: "pg_search", version: "~> 2.3"}
          ]
        end

        def template_lines
          [
            'rails_command "generate pg_search:migration:multisearch"'
          ]
        end

        def post_install_notes
          [
            "Search: Run `bin/rails db:migrate` to create pg_search tables",
            "Search: Add `include PgSearch::Model` to models you want to search",
            "Search: Requires PostgreSQL database"
          ]
        end
      end
    end
  end
end
