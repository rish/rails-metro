module Rails
  module Metro
    module Packs
      class SendgridPack < FeaturePack
        pack_name "sendgrid"
        description "SendGrid for transactional and marketing email delivery"
        category "notifications"

        def gems
          [
            {name: "sendgrid-ruby"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/sendgrid.rb", <<~RUBY',
            "  ActionMailer::Base.smtp_settings = {",
            '    user_name: "apikey",',
            '    password: Rails.application.credentials.dig(:sendgrid, :api_key) || ENV["SENDGRID_API_KEY"],',
            '    domain: Rails.application.credentials.dig(:sendgrid, :domain) || "example.com",',
            '    address: "smtp.sendgrid.net",',
            "    port: 587,",
            "    authentication: :plain,",
            "    enable_starttls_auto: true",
            "  }",
            "RUBY",
            "",
            'environment "config.action_mailer.delivery_method = :smtp", env: "production"'
          ]
        end

        def post_install_notes
          [
            "SendGrid: Add your API key with `bin/rails credentials:edit`:",
            "  sendgrid:",
            "    api_key: SG.your_api_key_here",
            "    domain: yourdomain.com"
          ]
        end
      end
    end
  end
end
