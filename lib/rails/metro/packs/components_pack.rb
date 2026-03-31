module Rails
  module Metro
    module Packs
      class ComponentsPack < FeaturePack
        pack_name "components"
        description "ViewComponent for component-based views"
        category "ui"

        def gems
          [
            {name: "view_component", version: "~> 3.0"}
          ]
        end

        def template_lines
          [
            'rails_command "generate component Example title --stimulus"'
          ]
        end

        def post_install_notes
          [
            "Components: Generate with `bin/rails g component MyComponent`",
            "Components: See https://viewcomponent.org for docs"
          ]
        end
      end
    end
  end
end
