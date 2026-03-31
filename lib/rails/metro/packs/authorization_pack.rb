module Rails
  module Metro
    module Packs
      class AuthorizationPack < FeaturePack
        pack_name "authorization"
        description "Action Policy for authorization (Rails-idiomatic, scoping, caching)"
        category "core"
        conflicts_with "pundit"

        def gems
          [
            {name: "action_policy", version: "~> 0.7"}
          ]
        end

        def template_lines
          [
            'rails_command "generate action_policy:install"'
          ]
        end

        def post_install_notes
          [
            "Authorization: Generate policies with `bin/rails g action_policy:policy User`",
            "Authorization: See https://actionpolicy.evilmartians.io for docs"
          ]
        end
      end
    end
  end
end
