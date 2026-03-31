module Rails
  module Metro
    module Packs
      class MaintenanceTasksPack < FeaturePack
        pack_name "maintenance_tasks"
        description "Maintenance Tasks (Shopify) for admin-triggered background tasks"
        category "ops"

        def gems
          [
            {name: "maintenance_tasks"}
          ]
        end

        def template_lines
          [
            'rails_command "generate maintenance_tasks:install"',
            'route "mount MaintenanceTasks::Engine => \\"/maintenance_tasks\\""'
          ]
        end

        def post_install_notes
          [
            "Maintenance Tasks: Run `bin/rails db:migrate` to create task tables",
            "Maintenance Tasks: Generate with `bin/rails g maintenance_tasks:task BackfillUsers`",
            "Maintenance Tasks: Trigger and monitor at /maintenance_tasks"
          ]
        end
      end
    end
  end
end
