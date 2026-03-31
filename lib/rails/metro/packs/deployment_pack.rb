module Rails
  module Metro
    module Packs
      class DeploymentPack < FeaturePack
        pack_name "deployment"
        description "Kamal for zero-downtime deploys to any Linux box"
        category "ops"

        def gems
          [
            {name: "kamal", version: "~> 2.0"}
          ]
        end

        def template_lines
          [
            'rails_command "generate kamal"'
          ]
        end

        def post_install_notes
          [
            "Deployment: Edit config/deploy.yml with your server details",
            "Deployment: Run `kamal setup` to provision, then `kamal deploy`"
          ]
        end
      end
    end
  end
end
