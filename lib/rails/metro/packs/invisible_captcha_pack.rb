module Rails
  module Metro
    module Packs
      class InvisibleCaptchaPack < FeaturePack
        pack_name "invisible_captcha"
        description "Invisible Captcha for honeypot-based spam prevention"
        category "core"

        def gems
          [
            {name: "invisible_captcha"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/invisible_captcha.rb", <<~RUBY',
            "  InvisibleCaptcha.setup do |config|",
            "    config.honeypots = [:subtitle, :city, :nickname]",
            "    config.timestamp_threshold = 2",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Invisible Captcha: Add `invisible_captcha` to forms that need spam protection",
            "Invisible Captcha: No user-facing CAPTCHA -- uses honeypots and timing"
          ]
        end
      end
    end
  end
end
