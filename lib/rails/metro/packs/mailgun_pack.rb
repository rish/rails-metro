module Rails
  module Metro
    module Packs
      class MailgunPack < FeaturePack
        pack_name "mailgun"
        description "Mailgun for transactional email delivery"
        category "notifications"

        def gems
          [
            {name: "mailgun-ruby"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/mailgun.rb", <<~RUBY',
            "  ActionMailer::Base.smtp_settings = {",
            "    port: 587,",
            '    address: "smtp.mailgun.org",',
            '    user_name: Rails.application.credentials.dig(:mailgun, :smtp_login) || ENV["MAILGUN_SMTP_LOGIN"],',
            '    password: Rails.application.credentials.dig(:mailgun, :smtp_password) || ENV["MAILGUN_SMTP_PASSWORD"],',
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
            "Mailgun: Add your credentials with `bin/rails credentials:edit`:",
            "  mailgun:",
            "    smtp_login: postmaster@yourdomain.com",
            "    smtp_password: your_smtp_password",
            "Mailgun: Verify your sending domain in the Mailgun dashboard"
          ]
        end
      end
    end
  end
end
