module Rails
  module Metro
    module Packs
      class RevenuecatPack < FeaturePack
        pack_name "revenuecat"
        description "RevenueCat for subscription management and in-app purchases"
        category "payments"

        def gems
          [
            {name: "revenuecat-api"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/revenuecat.rb", <<~RUBY',
            "  RevenueCat.configure do |config|",
            '    config.api_key = Rails.application.credentials.dig(:revenuecat, :api_key) || ENV["REVENUECAT_API_KEY"]',
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "RevenueCat: Add your API key with `bin/rails credentials:edit`:",
            "  revenuecat:",
            "    api_key: your_api_key_here",
            "RevenueCat: Best suited for apps with mobile (iOS/Android) subscription billing"
          ]
        end
      end
    end
  end
end
