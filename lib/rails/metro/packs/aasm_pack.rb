module Rails
  module Metro
    module Packs
      class AasmPack < FeaturePack
        pack_name "aasm"
        description "AASM for state machines in ActiveRecord models"
        category "data"

        def gems
          [
            {name: "aasm"}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "AASM: Add `include AASM` to models",
            "AASM: Define states with `aasm do; state :draft, initial: true; state :published; end`",
            "AASM: Define events with `event :publish do; transitions from: :draft, to: :published; end`"
          ]
        end
      end
    end
  end
end
