module Rails
  module Metro
    module Packs
      class PretenderPack < FeaturePack
        pack_name "pretender"
        description "Pretender for user impersonation (admin support tool)"
        category "ops"

        def gems
          [
            {name: "pretender"}
          ]
        end

        def template_lines
          [
            'inject_into_file "app/controllers/application_controller.rb", after: "class ApplicationController < ActionController::Base\\n" do',
            '  "  impersonates :user\\n"',
            "end"
          ]
        end

        def post_install_notes
          [
            "Pretender: Impersonate with `impersonate_user(user)` in a controller action",
            "Pretender: Stop with `stop_impersonating_user`",
            "Pretender: `true_user` returns the admin, `current_user` returns the impersonated user"
          ]
        end
      end
    end
  end
end
