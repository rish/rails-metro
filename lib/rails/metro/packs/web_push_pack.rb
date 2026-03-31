module Rails
  module Metro
    module Packs
      class WebPushPack < FeaturePack
        pack_name "web_push"
        description "Web Push for browser push notifications"
        category "notifications"

        def gems
          [
            {name: "web-push"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/web_push.rb", <<~RUBY',
            "  WebPush.configure do |config|",
            '    config.vapid_public_key = Rails.application.credentials.dig(:vapid, :public_key) || ENV["VAPID_PUBLIC_KEY"]',
            '    config.vapid_private_key = Rails.application.credentials.dig(:vapid, :private_key) || ENV["VAPID_PRIVATE_KEY"]',
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Web Push: Generate VAPID keys with `WebPush.generate_key`",
            "Web Push: Add keys with `bin/rails credentials:edit`:",
            "  vapid:",
            "    public_key: your_public_key",
            "    private_key: your_private_key",
            "Web Push: Register a service worker in your app for push subscriptions"
          ]
        end
      end
    end
  end
end
