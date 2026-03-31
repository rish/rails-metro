module Rails
  module Metro
    module Packs
      class RecaptchaPack < FeaturePack
        pack_name "recaptcha"
        description "reCAPTCHA v3 for Google-powered bot protection"
        category "core"

        def gems
          [
            {name: "recaptcha"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/recaptcha.rb", <<~RUBY',
            "  Recaptcha.configure do |config|",
            '    config.site_key = Rails.application.credentials.dig(:recaptcha, :site_key) || ENV["RECAPTCHA_SITE_KEY"]',
            '    config.secret_key = Rails.application.credentials.dig(:recaptcha, :secret_key) || ENV["RECAPTCHA_SECRET_KEY"]',
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "reCAPTCHA: Add your keys with `bin/rails credentials:edit`:",
            "  recaptcha:",
            "    site_key: your_site_key",
            "    secret_key: your_secret_key",
            "reCAPTCHA: Use `<%= recaptcha_v3 %>` in forms and `verify_recaptcha` in controllers"
          ]
        end
      end
    end
  end
end
