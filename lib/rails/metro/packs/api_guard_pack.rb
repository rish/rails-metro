module Rails
  module Metro
    module Packs
      class ApiGuardPack < FeaturePack
        pack_name "api_guard"
        description "API Guard for JWT authentication in Rails APIs"
        category "api"

        def gems
          [
            {name: "api_guard"}
          ]
        end

        def template_lines
          [
            'rails_command "generate api_guard:initializer"'
          ]
        end

        def post_install_notes
          [
            "API Guard: Run `bin/rails db:migrate` to create token tables",
            "API Guard: Add `api_guard_routes for: 'users'` to routes",
            "API Guard: Endpoints: POST /users/sign_in, DELETE /users/sign_out, POST /users/tokens"
          ]
        end
      end
    end
  end
end
