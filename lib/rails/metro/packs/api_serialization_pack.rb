module Rails
  module Metro
    module Packs
      class ApiSerializationPack < FeaturePack
        pack_name "api_serialization"
        description "Alba for fast, flexible JSON serialization"
        category "api"

        def gems
          [
            {name: "alba", version: "~> 3.0"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/alba.rb", <<~RUBY',
            "  Alba.backend = :oj",
            "RUBY",
            "",
            'create_file "app/resources/application_resource.rb", <<~RUBY',
            "  class ApplicationResource",
            "    include Alba::Resource",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Alba: Create resources in app/resources/ inheriting from ApplicationResource",
            "Alba: Use `UserResource.new(user).serialize` to generate JSON"
          ]
        end
      end
    end
  end
end
