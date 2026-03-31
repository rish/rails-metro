module Rails
  module Metro
    module Packs
      class BreadcrumbsPack < FeaturePack
        pack_name "breadcrumbs"
        description "Gretel for flexible breadcrumb navigation"
        category "ui"

        def gems
          [
            {name: "gretel"}
          ]
        end

        def template_lines
          [
            'rails_command "generate gretel:install"'
          ]
        end

        def post_install_notes
          [
            "Breadcrumbs: Define breadcrumbs in config/breadcrumbs.rb",
            "Breadcrumbs: Set in controllers with `breadcrumb :home, root_path`",
            "Breadcrumbs: Render with `<%= breadcrumbs %>` in layouts"
          ]
        end
      end
    end
  end
end
