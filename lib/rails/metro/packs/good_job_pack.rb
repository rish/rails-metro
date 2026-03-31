module Rails
  module Metro
    module Packs
      class GoodJobPack < FeaturePack
        pack_name "good_job"
        description "GoodJob for Postgres-backed background jobs (no Redis needed)"
        category "core"
        conflicts_with "background_jobs", "sidekiq"

        def gems
          [
            {name: "good_job", version: "~> 4.0"}
          ]
        end

        def template_lines
          [
            'environment "config.active_job.queue_adapter = :good_job"',
            'rails_command "generate good_job:install"',
            'route "mount GoodJob::Engine => \\"/good_job\\""'
          ]
        end

        def post_install_notes
          [
            "GoodJob: Run `bin/rails db:migrate` to create job tables",
            "GoodJob: Monitor jobs at /good_job",
            "GoodJob: Supports cron-like recurring jobs via config/good_job.yml"
          ]
        end
      end
    end
  end
end
