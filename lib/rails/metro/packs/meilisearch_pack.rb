module Rails
  module Metro
    module Packs
      class MeilisearchPack < FeaturePack
        pack_name "meilisearch"
        description "Meilisearch for typo-tolerant, fast full-text search"
        category "data"
        conflicts_with "search", "elasticsearch"

        def gems
          [
            {name: "meilisearch-rails"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/meilisearch.rb", <<~RUBY',
            "  MeiliSearch::Rails.configuration = {",
            '    meilisearch_url: Rails.application.credentials.dig(:meilisearch, :url) || ENV.fetch("MEILISEARCH_URL", "http://localhost:7700"),',
            '    meilisearch_api_key: Rails.application.credentials.dig(:meilisearch, :api_key) || ENV["MEILISEARCH_API_KEY"]',
            "  }",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Meilisearch: Install and run the Meilisearch server (see https://meilisearch.com)",
            "Meilisearch: Add `include MeiliSearch::Rails` to models",
            "Meilisearch: Use `Model.search(\"query\")` for instant search"
          ]
        end
      end
    end
  end
end
