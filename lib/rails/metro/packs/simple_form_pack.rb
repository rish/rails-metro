module Rails
  module Metro
    module Packs
      class SimpleFormPack < FeaturePack
        pack_name "simple_form"
        description "Simple Form for easy, flexible form building"
        category "ui"

        def gems
          [
            {name: "simple_form"}
          ]
        end

        def template_lines
          [
            'rails_command "generate simple_form:install"'
          ]
        end

        def post_install_notes
          [
            "Simple Form: Use `<%= simple_form_for @user do |f| %>` in views",
            "Simple Form: Customize wrappers in config/initializers/simple_form.rb"
          ]
        end
      end
    end
  end
end
