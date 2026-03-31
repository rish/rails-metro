module Rails
  module Metro
    module Packs
      class PlausiblePack < FeaturePack
        pack_name "plausible"
        description "Plausible -- privacy-focused analytics (no cookies, GDPR compliant)"
        category "analytics"

        def gems
          []
        end

        def template_lines
          [
            'create_file "app/views/layouts/_plausible.html.erb", <<~ERB',
            '  <script defer data-domain="<%%= Rails.application.credentials.dig(:plausible, :domain) || ENV["PLAUSIBLE_DOMAIN"] %>" src="<%%= Rails.application.credentials.dig(:plausible, :script_url) || "https://plausible.io/js/script.js" %>"></script>',
            "ERB",
            "",
            'inject_into_file "app/views/layouts/application.html.erb", after: "<head>\\n" do',
            '  "    <%= render \\"layouts/plausible\\" %>\\n"',
            "end"
          ]
        end

        def post_install_notes
          [
            "Plausible: Add your domain with `bin/rails credentials:edit`:",
            "  plausible:",
            "    domain: yourdomain.com",
            "Plausible: No cookie banner needed -- fully GDPR/CCPA/PECR compliant out of the box"
          ]
        end
      end
    end
  end
end
