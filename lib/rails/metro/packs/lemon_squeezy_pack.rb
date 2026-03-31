module Rails
  module Metro
    module Packs
      class LemonSqueezyPack < FeaturePack
        pack_name "lemon_squeezy"
        description "Lemon Squeezy -- merchant of record for SaaS (handles tax/VAT)"
        category "payments"

        def gems
          [
            {name: "lemon_squeezy"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/lemon_squeezy.rb", <<~RUBY',
            "  LemonSqueezy.configure do |config|",
            '    config.api_key = Rails.application.credentials.dig(:lemon_squeezy, :api_key) || ENV["LEMON_SQUEEZY_API_KEY"]',
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Lemon Squeezy: Add your API key with `bin/rails credentials:edit`:",
            "  lemon_squeezy:",
            "    api_key: your_api_key_here",
            "Lemon Squeezy: Acts as merchant of record -- handles sales tax, VAT, and billing for you"
          ]
        end
      end
    end
  end
end
