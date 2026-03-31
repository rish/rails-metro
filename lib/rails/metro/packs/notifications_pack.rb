module Rails
  module Metro
    module Packs
      class NotificationsPack < FeaturePack
        pack_name "notifications"
        description "Noticed for multi-channel notifications"
        category "notifications"

        def gems
          [
            {name: "noticed", version: "~> 2.0"}
          ]
        end

        def template_lines
          [
            'rails_command "noticed:install:migrations"',
            'rails_command "generate noticed:model"'
          ]
        end

        def post_install_notes
          [
            "Notifications: Run `bin/rails db:migrate` to create notification tables",
            "Notifications: Generate notifiers with `bin/rails g noticed:notifier CommentNotifier`"
          ]
        end
      end
    end
  end
end
