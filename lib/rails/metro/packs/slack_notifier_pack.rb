module Rails
  module Metro
    module Packs
      class SlackNotifierPack < FeaturePack
        pack_name "slack_notifier"
        description "Slack Notifier for sending webhook notifications to Slack"
        category "notifications"

        def gems
          [
            {name: "slack-notifier"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/slack.rb", <<~RUBY',
            "  SLACK_NOTIFIER = Slack::Notifier.new(",
            '    Rails.application.credentials.dig(:slack, :webhook_url) || ENV["SLACK_WEBHOOK_URL"]',
            "  )",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Slack: Add your webhook URL with `bin/rails credentials:edit`:",
            "  slack:",
            "    webhook_url: https://hooks.slack.com/services/...",
            "Slack: Send with `SLACK_NOTIFIER.ping(\"Hello from Rails!\")`"
          ]
        end
      end
    end
  end
end
