module Rails
  module Metro
    module Packs
      class MolliePack < FeaturePack
        pack_name "mollie"
        description "Mollie for European payment processing"
        category "payments"

        def gems
          [
            {name: "mollie-api-ruby"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/mollie.rb", <<~RUBY',
            "  Mollie::Client.configure do |config|",
            '    config.api_key = Rails.application.credentials.dig(:mollie, :api_key) || ENV["MOLLIE_API_KEY"]',
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Mollie: Add your API key with `bin/rails credentials:edit`:",
            "  mollie:",
            "    api_key: test_your_api_key_here",
            "Mollie: Supports iDEAL, Bancontact, SEPA, credit cards, and more EU payment methods"
          ]
        end
      end
    end
  end
end
