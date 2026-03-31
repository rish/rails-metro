module Rails
  module Metro
    module Packs
      class DataMigratePack < FeaturePack
        pack_name "data_migrate"
        description "Data Migrate for separating data migrations from schema migrations"
        category "data"

        def gems
          [
            {name: "data_migrate"}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "Data Migrate: Generate with `bin/rails g data_migration backfill_users`",
            "Data Migrate: Run with `bin/rails data:migrate`",
            "Data Migrate: Data migrations live in db/data/ separate from schema migrations"
          ]
        end
      end
    end
  end
end
