module Rails
  module Metro
    module Packs
      class PaymentsPack < FeaturePack
        pack_name "payments"
        description "Pay + Stripe for subscriptions and billing"
        category "payments"

        def gems
          [
            {name: "pay", version: "~> 7.0"},
            {name: "stripe", version: "~> 12.0"}
          ]
        end

        def template_lines
          [
            'rails_command "pay:install:migrations"'
          ]
        end

        def post_install_notes
          [
            "Payments: Run `bin/rails db:migrate` to create Pay tables",
            "Payments: Add Stripe keys with `bin/rails credentials:edit`:",
            "  stripe:",
            "    private_key: sk_test_...",
            "    public_key: pk_test_...",
            "    signing_secret: whsec_..."
          ]
        end
      end
    end
  end
end
