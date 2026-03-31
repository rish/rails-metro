module Rails
  module Metro
    module Packs
      class ActionTextPack < FeaturePack
        pack_name "action_text"
        description "Action Text for rich text editing with Trix"
        category "ui"

        def gems
          []
        end

        def template_lines
          [
            'rails_command "action_text:install"'
          ]
        end

        def post_install_notes
          [
            "Action Text: Run `bin/rails db:migrate` to create rich text tables",
            "Action Text: Add `has_rich_text :body` to models",
            "Action Text: Use `<%= form.rich_text_area :body %>` in forms"
          ]
        end
      end
    end
  end
end
