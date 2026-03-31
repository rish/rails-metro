module Rails
  module Metro
    module Packs
      class ResendPack < FeaturePack
        pack_name "resend"
        description "Resend for transactional and marketing email delivery"
        category "notifications"

        def gems
          [
            {name: "resend"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/resend.rb", <<~RUBY',
            "  Resend.api_key = Rails.application.credentials.dig(:resend, :api_key) || ENV[\"RESEND_API_KEY\"]",
            "RUBY",
            "",
            "# Configure Action Mailer to use Resend",
            'environment "config.action_mailer.delivery_method = :resend", env: "production"'
          ]
        end

        def post_install_notes
          [
            "Resend: Add your API key with `bin/rails credentials:edit`:",
            "  resend:",
            "    api_key: re_your_api_key_here",
            "Resend: Verify your sending domain at https://resend.com/domains"
          ]
        end
      end
    end
  end
end
