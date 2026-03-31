module Rails
  module Metro
    module Packs
      class LetterOpenerWebPack < FeaturePack
        pack_name "letter_opener_web"
        description "Letter Opener Web for browsable email inbox in development"
        category "ops"
        depends_on "letter_opener"

        def gems
          [
            {name: "letter_opener_web", group: :development}
          ]
        end

        def template_lines
          [
            'environment "config.action_mailer.delivery_method = :letter_opener_web", env: "development"',
            'route "mount LetterOpenerWeb::Engine, at: \\"/letter_opener\\" if Rails.env.development?"'
          ]
        end

        def post_install_notes
          [
            "Letter Opener Web: Browse all sent emails at /letter_opener in development",
            "Letter Opener Web: Provides a persistent inbox UI (vs letter_opener which just opens a tab)"
          ]
        end
      end
    end
  end
end
