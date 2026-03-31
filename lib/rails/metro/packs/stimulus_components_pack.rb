module Rails
  module Metro
    module Packs
      class StimulusComponentsPack < FeaturePack
        pack_name "stimulus_components"
        description "Stimulus Components -- pre-built Stimulus controllers (dropdowns, modals, etc.)"
        category "ui"

        def gems
          [
            {name: "stimulus-rails"}
          ]
        end

        def template_lines
          [
            'append_to_file "config/importmap.rb", <<~RUBY',
            '  pin "stimulus-use", to: "https://ga.jspm.io/npm:stimulus-use/dist/index.js"',
            '  pin "stimulus-components", to: "https://ga.jspm.io/npm:stimulus-components/dist/index.js"',
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Stimulus Components: Pre-built controllers for dropdowns, modals, tabs, clipboard, etc.",
            "Stimulus Components: See https://www.stimulus-components.com for full list"
          ]
        end
      end
    end
  end
end
