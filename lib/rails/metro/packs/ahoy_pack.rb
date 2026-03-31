module Rails
  module Metro
    module Packs
      class AhoyPack < FeaturePack
        pack_name "ahoy"
        description "Ahoy for visit and event tracking (first-party analytics)"
        category "analytics"

        def gems
          [
            {name: "ahoy_matey"}
          ]
        end

        def template_lines
          [
            'rails_command "generate ahoy:install"'
          ]
        end

        def post_install_notes
          [
            "Ahoy: Run `bin/rails db:migrate` to create visits and events tables",
            "Ahoy: Track events with `ahoy.track \"Viewed product\", product_id: product.id`",
            "Ahoy: Visits auto-tracked -- access with `current_visit` in controllers"
          ]
        end
      end
    end
  end
end
