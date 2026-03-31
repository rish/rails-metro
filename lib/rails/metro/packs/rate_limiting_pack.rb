module Rails
  module Metro
    module Packs
      class RateLimitingPack < FeaturePack
        pack_name "rate_limiting"
        description "Rack::Attack for throttling and blocking"
        category "ops"

        def gems
          [
            {name: "rack-attack"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/rack_attack.rb", <<~RUBY',
            "  class Rack::Attack",
            '    throttle("req/ip", limit: 300, period: 5.minutes) do |req|',
            "      req.ip",
            "    end",
            "",
            '    throttle("logins/ip", limit: 5, period: 20.seconds) do |req|',
            '      req.ip if req.path == "/session" && req.post?',
            "    end",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Rate Limiting: Customize throttle rules in config/initializers/rack_attack.rb"
          ]
        end
      end
    end
  end
end
