module Rails
  module Metro
    module Packs
      class MultitenancyPack < FeaturePack
        pack_name "multitenancy"
        description "acts_as_tenant for row-based multi-tenancy"
        category "core"

        def gems
          [
            {name: "acts_as_tenant"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/acts_as_tenant.rb", <<~RUBY',
            "  ActsAsTenant.configure do |config|",
            "    config.require_tenant = true",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Multitenancy: Add `set_current_tenant_through_filter` to ApplicationController",
            "Multitenancy: Add `acts_as_tenant :account` to tenant-scoped models",
            "Multitenancy: All queries are automatically scoped to current tenant"
          ]
        end
      end
    end
  end
end
