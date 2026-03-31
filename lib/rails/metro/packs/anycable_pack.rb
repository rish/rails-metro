module Rails
  module Metro
    module Packs
      class AnycablePack < FeaturePack
        pack_name "anycable"
        description "AnyCable — high-performance WebSocket server replacing ActionCable"
        category "core"

        conflicts_with "websockets"

        def gems
          [
            {name: "anycable-rails"}
          ]
        end

        def template_lines
          [
            'generate "anycable:setup"'
          ]
        end

        def post_install_notes
          [
            "AnyCable: Install the AnyCable Go server: https://docs.anycable.io/anycable-go/getting_started",
            "AnyCable: Start alongside Rails with: anycable & rails s",
            "AnyCable: See https://docs.anycable.io for full configuration"
          ]
        end
      end
    end
  end
end
