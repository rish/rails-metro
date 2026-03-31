module Rails
  module Metro
    module Packs
      class WebhooksPack < FeaturePack
        pack_name "webhooks"
        description "Incoming and outgoing webhook handling"
        category "api"

        def gems
          [
            {name: "webhook_system"}
          ]
        end

        def template_lines
          [
            'create_file "app/controllers/webhooks_controller.rb", <<~RUBY',
            "  class WebhooksController < ActionController::API",
            "    skip_before_action :verify_authenticity_token",
            "",
            "    def receive",
            "      payload = JSON.parse(request.body.read)",
            '      signature = request.headers["X-Webhook-Signature"]',
            "",
            "      # Verify and process webhook",
            '      Rails.logger.info "[Webhook] Received: \#{payload}"',
            "      head :ok",
            "    end",
            "  end",
            "RUBY",
            "",
            'route "post \\"/webhooks/:provider\\", to: \\"webhooks#receive\\""'
          ]
        end

        def post_install_notes
          [
            "Webhooks: Incoming endpoint at POST /webhooks/:provider",
            "Webhooks: Add signature verification per provider in WebhooksController"
          ]
        end
      end
    end
  end
end
