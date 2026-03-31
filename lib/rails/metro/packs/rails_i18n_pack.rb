module Rails
  module Metro
    module Packs
      class RailsI18nPack < FeaturePack
        pack_name "rails_i18n"
        description "Rails I18n locale data for 100+ languages"
        category "core"

        def gems
          [
            {name: "rails-i18n"}
          ]
        end

        def template_lines
          [
            'environment "config.i18n.available_locales = [:en]',
            '  config.i18n.default_locale = :en"'
          ]
        end

        def post_install_notes
          [
            "I18n: Add locales to config.i18n.available_locales as needed",
            "I18n: Locale files available for 100+ languages (date formats, pluralization, etc.)"
          ]
        end
      end
    end
  end
end
