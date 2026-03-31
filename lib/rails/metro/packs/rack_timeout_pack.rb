module Rails
  module Metro
    module Packs
      class RackTimeoutPack < FeaturePack
        pack_name "rack_timeout"
        description "Rack::Timeout for request timeout protection"
        category "ops"

        def gems
          [
            {name: "rack-timeout"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/rack_timeout.rb", <<~RUBY',
            "  Rack::Timeout.service_timeout = 15",
            "  Rack::Timeout.wait_timeout = 30",
            "  Rack::Timeout.wait_overtime = 60",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Rack::Timeout: Requests exceeding 15s are terminated with a Rack::Timeout::RequestTimeoutError",
            "Rack::Timeout: Customize thresholds in config/initializers/rack_timeout.rb"
          ]
        end
      end
    end
  end
end
