module Rails
  module Metro
    module Packs
      class PerformancePack < FeaturePack
        pack_name "performance"
        description "Rack Mini Profiler + Bullet for performance debugging"
        category "ops"

        def gems
          [
            {name: "rack-mini-profiler", group: :development},
            {name: "bullet", group: :development}
          ]
        end

        def template_lines
          [
            'environment "config.after_initialize do',
            "    Bullet.enable = true",
            "    Bullet.alert = true",
            "    Bullet.bullet_logger = true",
            "    Bullet.console = true",
            "    Bullet.rails_logger = true",
            '  end", env: "development"'
          ]
        end

        def post_install_notes
          [
            "Performance: Rack Mini Profiler badge appears top-left in development",
            "Performance: Bullet alerts on N+1 queries and unused eager loading in development"
          ]
        end
      end
    end
  end
end
