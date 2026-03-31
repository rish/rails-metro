module Rails
  module Metro
    module Packs
      class PostmarkPack < FeaturePack
        pack_name "postmark"
        description "Postmark for fast transactional email (99%+ inbox delivery)"
        category "notifications"

        def gems
          [
            {name: "postmark-rails"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/postmark.rb", <<~RUBY',
            "  ActionMailer::Base.delivery_method = :postmark",
            "  ActionMailer::Base.postmark_settings = {",
            '    api_token: Rails.application.credentials.dig(:postmark, :api_token) || ENV["POSTMARK_API_TOKEN"]',
            "  }",
            "RUBY",
            "",
            'environment "config.action_mailer.delivery_method = :postmark", env: "production"'
          ]
        end

        def post_install_notes
          [
            "Postmark: Add your API token with `bin/rails credentials:edit`:",
            "  postmark:",
            "    api_token: your_server_api_token",
            "Postmark: Known for excellent deliverability and fast delivery times"
          ]
        end
      end
    end
  end
end
