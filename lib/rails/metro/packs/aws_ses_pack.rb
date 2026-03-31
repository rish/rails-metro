module Rails
  module Metro
    module Packs
      class AwsSesPack < FeaturePack
        pack_name "aws_ses"
        description "Amazon SES for high-volume email delivery"
        category "notifications"

        def gems
          [
            {name: "aws-sdk-sesv2"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/aws_ses.rb", <<~RUBY',
            "  ActionMailer::Base.smtp_settings = {",
            '    address: "email-smtp.\#{Rails.application.credentials.dig(:aws_ses, :region) || ENV["AWS_REGION"] || "us-east-1"}.amazonaws.com",',
            "    port: 587,",
            '    user_name: Rails.application.credentials.dig(:aws_ses, :smtp_username) || ENV["AWS_SES_SMTP_USERNAME"],',
            '    password: Rails.application.credentials.dig(:aws_ses, :smtp_password) || ENV["AWS_SES_SMTP_PASSWORD"],',
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
            "AWS SES: Add your SMTP credentials with `bin/rails credentials:edit`:",
            "  aws_ses:",
            "    smtp_username: your_smtp_username",
            "    smtp_password: your_smtp_password",
            "    region: us-east-1",
            "AWS SES: Verify your sending domain/email in the AWS SES console"
          ]
        end
      end
    end
  end
end
