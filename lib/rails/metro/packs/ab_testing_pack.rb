module Rails
  module Metro
    module Packs
      class AbTestingPack < FeaturePack
        pack_name "ab_testing"
        description "Split for A/B testing and experiments"
        category "data"

        def gems
          [
            {name: "split", version: "~> 4.0"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/split.rb", <<~RUBY',
            "  Split.configure do |config|",
            "    config.allow_multiple_experiments = true",
            "    config.persistence = Split::Persistence::SessionAdapter",
            "  end",
            "RUBY",
            "",
            'route "mount Split::Dashboard, at: \\"/split\\""'
          ]
        end

        def post_install_notes
          [
            "Split: Requires Redis for experiment storage",
            "Split: Use `ab_test(\"button_color\", \"red\", \"blue\")` in views/controllers",
            "Split: Call `ab_finished(\"button_color\")` on conversion",
            "Split: Dashboard at /split"
          ]
        end
      end
    end
  end
end
