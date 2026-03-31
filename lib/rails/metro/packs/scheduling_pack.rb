module Rails
  module Metro
    module Packs
      class SchedulingPack < FeaturePack
        pack_name "scheduling"
        description "Recurring tasks with Solid Queue and solid_queue recurring"
        category "core"
        depends_on "background_jobs"

        def gems
          []
        end

        def template_lines
          [
            'create_file "config/recurring.yml", <<~YML',
            "  production:",
            "    cleanup_old_records:",
            "      class: CleanupOldRecordsJob",
            '      schedule: "every day at 3am"',
            "      queue: default",
            "YML",
            "",
            'create_file "app/jobs/cleanup_old_records_job.rb", <<~RUBY',
            "  class CleanupOldRecordsJob < ApplicationJob",
            "    queue_as :default",
            "",
            "    def perform",
            "      # Add your recurring cleanup logic here",
            '      Rails.logger.info "Running scheduled cleanup"',
            "    end",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Scheduling: Define recurring jobs in config/recurring.yml",
            "Scheduling: Solid Queue handles scheduling natively -- no cron or external gems needed"
          ]
        end
      end
    end
  end
end
