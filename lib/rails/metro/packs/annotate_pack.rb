module Rails
  module Metro
    module Packs
      class AnnotatePack < FeaturePack
        pack_name "annotate"
        description "Annotate models and routes with schema info"
        category "data"

        def gems
          [
            {name: "annotaterb", group: :development}
          ]
        end

        def template_lines
          [
            'rails_command "generate annotate_rb:install"'
          ]
        end

        def post_install_notes
          [
            "Annotate: Schema comments are auto-added to models after migrations",
            "Annotate: Run `bin/rails annotate_models` to annotate manually"
          ]
        end
      end
    end
  end
end
