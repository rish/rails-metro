module Rails
  module Metro
    module Packs
      class PgheroPack < FeaturePack
        pack_name "pghero"
        description "PgHero for Postgres performance dashboard"
        category "ops"

        def gems
          [
            {name: "pghero"}
          ]
        end

        def template_lines
          [
            'route "mount PgHero::Engine, at: \\"pghero\\""'
          ]
        end

        def post_install_notes
          [
            "PgHero: Dashboard at /pghero",
            "PgHero: Shows slow queries, index usage, connections, and space usage",
            "PgHero: Requires PostgreSQL"
          ]
        end
      end
    end
  end
end
