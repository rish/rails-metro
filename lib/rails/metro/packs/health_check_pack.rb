module Rails
  module Metro
    module Packs
      class HealthCheckPack < FeaturePack
        pack_name "health_check"
        description "OkComputer for health check endpoints (load balancers, k8s)"
        category "ops"

        def gems
          [
            {name: "okcomputer"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/okcomputer.rb", <<~RUBY',
            '  OkComputer::Registry.register "database", OkComputer::ActiveRecordCheck.new',
            '  OkComputer::Registry.register "cache", OkComputer::GenericCacheCheck.new',
            "  OkComputer.mount_at = \"health\"",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Health Check: Endpoints at /health and /health/all",
            "Health Check: Point load balancer/k8s probes at /health"
          ]
        end
      end
    end
  end
end
