module Rails
  module Metro
    module Packs
      class ElasticsearchPack < FeaturePack
        pack_name "elasticsearch"
        description "Searchkick for Elasticsearch-powered search"
        category "data"
        conflicts_with "search", "meilisearch"

        def gems
          [
            {name: "searchkick"}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "Searchkick: Install and run Elasticsearch (or OpenSearch)",
            "Searchkick: Add `searchkick` to models you want to search",
            "Searchkick: Reindex with `Model.reindex`",
            "Searchkick: Search with `Model.search(\"query\")`"
          ]
        end
      end
    end
  end
end
