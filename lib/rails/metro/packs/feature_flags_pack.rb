module Rails
  module Metro
    module Packs
      class FeatureFlagsPack < FeaturePack
        pack_name "feature_flags"
        description "Flipper for feature flags with web UI"
        category "ops"

        def gems
          [
            {name: "flipper"},
            {name: "flipper-active_record"},
            {name: "flipper-ui"}
          ]
        end

        def template_lines
          [
            'rails_command "generate flipper:setup"',
            'route "mount Flipper::UI.app(Flipper) => \\"/flipper\\""'
          ]
        end

        def post_install_notes
          [
            "Feature Flags: Run `bin/rails db:migrate` to create Flipper tables",
            "Feature Flags: Manage flags at /flipper",
            "Feature Flags: Use `Flipper.enabled?(:my_feature)` in code"
          ]
        end
      end
    end
  end
end
