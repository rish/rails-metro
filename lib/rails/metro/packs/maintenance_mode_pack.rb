module Rails
  module Metro
    module Packs
      class MaintenanceModePack < FeaturePack
        pack_name "maintenance_mode"
        description "Turnout for easy maintenance mode pages"
        category "ops"

        def gems
          [
            {name: "turnout"}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "Maintenance Mode: Enable with `rake maintenance:start`",
            "Maintenance Mode: Disable with `rake maintenance:end`",
            "Maintenance Mode: Customize page in public/maintenance.html",
            "Maintenance Mode: Allow specific IPs with `rake maintenance:start ALLOWED_IPS=1.2.3.4`"
          ]
        end
      end
    end
  end
end
