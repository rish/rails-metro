module Rails
  module Metro
    module Packs
      class TwilioPack < FeaturePack
        pack_name "twilio"
        description "Twilio for SMS, voice, and WhatsApp messaging"
        category "notifications"

        def gems
          [
            {name: "twilio-ruby"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/twilio.rb", <<~RUBY',
            "  TWILIO_CLIENT = Twilio::REST::Client.new(",
            '    Rails.application.credentials.dig(:twilio, :account_sid) || ENV["TWILIO_ACCOUNT_SID"],',
            '    Rails.application.credentials.dig(:twilio, :auth_token) || ENV["TWILIO_AUTH_TOKEN"]',
            "  )",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Twilio: Add your credentials with `bin/rails credentials:edit`:",
            "  twilio:",
            "    account_sid: your_account_sid",
            "    auth_token: your_auth_token",
            "    phone_number: \"+1234567890\""
          ]
        end
      end
    end
  end
end
