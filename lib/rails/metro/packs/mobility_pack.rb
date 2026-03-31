module Rails
  module Metro
    module Packs
      class MobilityPack < FeaturePack
        pack_name "mobility"
        description "Mobility for translatable model attributes (i18n)"
        category "core"

        def gems
          [
            {name: "mobility", version: "~> 1.3"},
            {name: "mobility-ransack"}
          ]
        end

        def template_lines
          [
            'rails_command "generate mobility:install"'
          ]
        end

        def post_install_notes
          [
            "Mobility: Run `bin/rails db:migrate` to create translation tables",
            "Mobility: Add `extend Mobility` and `translates :title, type: :string` to models",
            "Mobility: Set locale with `Mobility.locale = :fr` or use `I18n.locale`"
          ]
        end
      end
    end
  end
end
