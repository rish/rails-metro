module Rails
  module Metro
    module Packs
      class OmniauthPack < FeaturePack
        pack_name "omniauth"
        description "OmniAuth for social/OAuth login (Google, GitHub, etc.)"
        category "core"

        def gems
          [
            {name: "omniauth"},
            {name: "omniauth-rails_csrf_protection"},
            {name: "omniauth-google-oauth2"},
            {name: "omniauth-github"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/omniauth.rb", <<~RUBY',
            "  Rails.application.config.middleware.use OmniAuth::Builder do",
            "    provider :google_oauth2,",
            '      Rails.application.credentials.dig(:google, :client_id) || ENV["GOOGLE_CLIENT_ID"],',
            '      Rails.application.credentials.dig(:google, :client_secret) || ENV["GOOGLE_CLIENT_SECRET"]',
            "",
            "    provider :github,",
            '      Rails.application.credentials.dig(:github, :client_id) || ENV["GITHUB_CLIENT_ID"],',
            '      Rails.application.credentials.dig(:github, :client_secret) || ENV["GITHUB_CLIENT_SECRET"]',
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "OmniAuth: Add OAuth credentials with `bin/rails credentials:edit`:",
            "  google:",
            "    client_id: your_client_id",
            "    client_secret: your_client_secret",
            "  github:",
            "    client_id: your_client_id",
            "    client_secret: your_client_secret",
            "OmniAuth: Create a callback controller to handle /auth/:provider/callback"
          ]
        end
      end
    end
  end
end
