module Rails
  module Metro
    module Packs
      class PaddlePack < FeaturePack
        pack_name "paddle"
        description "Paddle -- merchant of record for SaaS (handles tax/VAT globally)"
        category "payments"

        def gems
          [
            {name: "paddle"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/paddle.rb", <<~RUBY',
            "  Paddle.configure do |config|",
            '    config.api_key = Rails.application.credentials.dig(:paddle, :api_key) || ENV["PADDLE_API_KEY"]',
            "    config.environment = Rails.env.production? ? :production : :sandbox",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Paddle: Add your API key with `bin/rails credentials:edit`:",
            "  paddle:",
            "    api_key: your_api_key_here",
            "Paddle: Acts as merchant of record -- handles sales tax, VAT, and invoicing globally"
          ]
        end
      end
    end
  end
end
