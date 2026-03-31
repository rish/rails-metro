module Rails
  module Metro
    module Packs
      class FaradayPack < FeaturePack
        pack_name "faraday"
        description "Faraday for composable HTTP client requests"
        category "core"

        def gems
          [
            {name: "faraday", version: "~> 2.0"},
            {name: "faraday-retry"}
          ]
        end

        def template_lines
          [
            'create_file "app/clients/application_client.rb", <<~RUBY',
            "  class ApplicationClient",
            "    def connection",
            "      @connection ||= Faraday.new do |f|",
            "        f.request :json",
            "        f.response :json",
            "        f.request :retry, max: 2, interval: 0.5",
            "        f.adapter Faraday.default_adapter",
            "      end",
            "    end",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Faraday: Base client class at app/clients/application_client.rb",
            "Faraday: Create service-specific clients inheriting from ApplicationClient"
          ]
        end
      end
    end
  end
end
