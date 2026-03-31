module Rails
  module Metro
    module Packs
      class WebsocketsPack < FeaturePack
        pack_name "websockets"
        description "Solid Cable (Rails 8 default, database-backed ActionCable)"
        category "core"

        def gems
          [
            {name: "solid_cable"}
          ]
        end

        def template_lines
          [
            'rails_command "solid_cable:install"'
          ]
        end

        def post_install_notes
          [
            "WebSockets: Solid Cable is configured as the ActionCable adapter"
          ]
        end
      end
    end
  end
end
