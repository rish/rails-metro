module Rails
  module Metro
    module Packs
      class SecurityPack < FeaturePack
        pack_name "security"
        description "Brakeman + bundler-audit for security scanning"
        category "ops"

        def gems
          [
            {name: "brakeman", group: :development},
            {name: "bundler-audit", group: :development}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "Security: Run `bundle exec brakeman` to scan for vulnerabilities",
            "Security: Run `bundle exec bundler-audit check --update` to check gem CVEs",
            "Security: Add both to CI for continuous security checks"
          ]
        end
      end
    end
  end
end
