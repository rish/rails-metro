module Rails
  module Metro
    module Packs
      class SentDmPack < FeaturePack
        pack_name "sent_dm"
        description "Sent.dm for multi-channel message delivery (email, SMS, push)"
        category "notifications"

        def gems
          [
            {name: "sent_dm"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/sent_dm.rb", <<~RUBY',
            "  SentDm.configure do |config|",
            '    config.api_key = Rails.application.credentials.dig(:sent_dm, :api_key) || ENV["SENT_DM_API_KEY"]',
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Sent.dm: Add your API key with `bin/rails credentials:edit`:",
            "  sent_dm:",
            "    api_key: your_api_key_here",
            "Sent.dm: Supports email, SMS, and push notifications from a single API"
          ]
        end
      end
    end
  end
end
