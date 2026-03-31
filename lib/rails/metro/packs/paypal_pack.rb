module Rails
  module Metro
    module Packs
      class PaypalPack < FeaturePack
        pack_name "paypal"
        description "PayPal for payments, checkout, and subscriptions"
        category "payments"

        def gems
          [
            {name: "paypal-server-sdk"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/paypal.rb", <<~RUBY',
            '  PAYPAL_CLIENT_ID = Rails.application.credentials.dig(:paypal, :client_id) || ENV["PAYPAL_CLIENT_ID"]',
            '  PAYPAL_CLIENT_SECRET = Rails.application.credentials.dig(:paypal, :client_secret) || ENV["PAYPAL_CLIENT_SECRET"]',
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "PayPal: Add your credentials with `bin/rails credentials:edit`:",
            "  paypal:",
            "    client_id: your_client_id",
            "    client_secret: your_client_secret"
          ]
        end
      end
    end
  end
end
