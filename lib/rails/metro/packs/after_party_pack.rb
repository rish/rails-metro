module Rails
  module Metro
    module Packs
      class AfterPartyPack < FeaturePack
        pack_name "after_party"
        description "AfterParty for one-time post-deploy tasks"
        category "ops"

        def gems
          [
            {name: "after_party"}
          ]
        end

        def template_lines
          [
            'rails_command "generate after_party:install"'
          ]
        end

        def post_install_notes
          [
            "AfterParty: Generate tasks with `bin/rails g after_party:task seed_admin_user`",
            "AfterParty: Run with `bin/rails after_party:run`",
            "AfterParty: Tasks only run once (tracked in task_records table)"
          ]
        end
      end
    end
  end
end
