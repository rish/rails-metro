module Rails
  module Metro
    module Packs
      class ApiDocsPack < FeaturePack
        pack_name "api_docs"
        description "Rswag for Swagger/OpenAPI documentation from tests"
        category "api"

        def gems
          [
            {name: "rswag-api"},
            {name: "rswag-ui"},
            {name: "rswag-specs", group: :test}
          ]
        end

        def template_lines
          [
            'rails_command "generate rswag:api:install"',
            'rails_command "generate rswag:ui:install"'
          ]
        end

        def post_install_notes
          [
            "Rswag: Write request specs with `describe 'API', swagger_doc: 'v1/swagger.yaml'`",
            "Rswag: Generate docs with `rake rswag:specs:swaggerize`",
            "Rswag: Swagger UI available at /api-docs"
          ]
        end
      end
    end
  end
end
