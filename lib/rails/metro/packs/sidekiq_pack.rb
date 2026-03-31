module Rails
  module Metro
    module Packs
      class SidekiqPack < FeaturePack
        pack_name "sidekiq"
        description "Sidekiq for Redis-backed background jobs (high throughput)"
        category "core"
        conflicts_with "background_jobs", "good_job"

        def gems
          [
            {name: "sidekiq", version: "~> 7.0"}
          ]
        end

        def template_lines
          [
            'environment "config.active_job.queue_adapter = :sidekiq"',
            "",
            'create_file "config/sidekiq.yml", <<~YML',
            "  :concurrency: 5",
            "  :queues:",
            "    - default",
            "    - mailers",
            "YML",
            "",
            'route "require \\"sidekiq/web\\"',
            "  mount Sidekiq::Web => \\\"/sidekiq\\\"\""
          ]
        end

        def post_install_notes
          [
            "Sidekiq: Requires Redis -- install and run `redis-server`",
            "Sidekiq: Start worker with `bundle exec sidekiq`",
            "Sidekiq: Monitor jobs at /sidekiq"
          ]
        end
      end
    end
  end
end
