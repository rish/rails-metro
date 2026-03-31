module Rails
  module Metro
    module Packs
      class ApiCorsPack < FeaturePack
        pack_name "api_cors"
        description "Rack CORS for cross-origin API requests"
        category "api"

        def gems
          [
            {name: "rack-cors"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/cors.rb", <<~RUBY',
            "  Rails.application.config.middleware.insert_before 0, Rack::Cors do",
            "    allow do",
            '      origins Rails.application.credentials.dig(:cors, :origins) || ENV.fetch("CORS_ORIGINS", "http://localhost:3000")',
            "",
            "      resource \"*\",",
            "        headers: :any,",
            "        methods: %i[get post put patch delete options head],",
            "        credentials: true",
            "    end",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "CORS: Update allowed origins in config/initializers/cors.rb",
            "CORS: Set CORS_ORIGINS env var in production (comma-separated domains)"
          ]
        end
      end
    end
  end
end
