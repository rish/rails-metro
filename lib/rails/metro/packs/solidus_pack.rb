module Rails
  module Metro
    module Packs
      class SolidusPack < FeaturePack
        pack_name "solidus"
        description "Solidus for full-featured e-commerce (products, orders, payments)"
        category "payments"

        def gems
          [
            {name: "solidus"}
          ]
        end

        def template_lines
          [
            'rails_command "generate solidus:install --auto-accept"'
          ]
        end

        def post_install_notes
          [
            "Solidus: Run `bin/rails db:migrate` and `bin/rails db:seed` to set up",
            "Solidus: Admin panel at /admin (default: admin@example.com / test123)",
            "Solidus: See https://solidus.io/docs for customization guides"
          ]
        end
      end
    end
  end
end
