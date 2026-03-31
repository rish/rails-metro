module Rails
  module Metro
    module Packs
      class BackgroundJobsPack < FeaturePack
        pack_name "background_jobs"
        description "Solid Queue + Mission Control Jobs (Rails 8 default, no Redis)"
        category "core"
        conflicts_with "sidekiq", "good_job"

        def gems
          [
            {name: "solid_queue"},
            {name: "mission_control-jobs"}
          ]
        end

        def template_lines
          [
            'rails_command "solid_queue:install"',
            'route "mount MissionControl::Jobs::Engine, at: \\"/jobs\\""'
          ]
        end

        def post_install_notes
          [
            "Background Jobs: Run `bin/rails db:migrate` to create Solid Queue tables",
            "Background Jobs: Monitor jobs at /jobs",
            "Background Jobs: Start the worker with `bin/jobs`"
          ]
        end
      end
    end
  end
end
