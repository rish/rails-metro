module Rails
  module Metro
    module Packs
      class LetterOpenerPack < FeaturePack
        pack_name "letter_opener"
        description "Letter Opener for previewing emails in the browser (dev)"
        category "ops"

        def gems
          [
            {name: "letter_opener", group: :development}
          ]
        end

        def template_lines
          [
            'environment "config.action_mailer.delivery_method = :letter_opener", env: "development"',
            'environment "config.action_mailer.perform_deliveries = true", env: "development"'
          ]
        end

        def post_install_notes
          [
            "Letter Opener: Emails open in your browser automatically in development",
            "Letter Opener: No SMTP setup needed for dev -- just send and it pops up"
          ]
        end
      end
    end
  end
end
