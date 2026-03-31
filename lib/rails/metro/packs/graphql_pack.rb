module Rails
  module Metro
    module Packs
      class GraphqlPack < FeaturePack
        pack_name "graphql"
        description "GraphQL API with graphql-ruby"
        category "api"

        def gems
          [
            {name: "graphql", version: "~> 2.0"}
          ]
        end

        def template_lines
          [
            'rails_command "generate graphql:install"'
          ]
        end

        def post_install_notes
          [
            "GraphQL: Endpoint available at /graphql",
            "GraphQL: Generate types with `bin/rails g graphql:object User`",
            "GraphQL: GraphiQL IDE available in development at /graphiql"
          ]
        end
      end
    end
  end
end
