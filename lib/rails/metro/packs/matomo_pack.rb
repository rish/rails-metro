module Rails
  module Metro
    module Packs
      class MatomoPack < FeaturePack
        pack_name "matomo"
        description "Matomo -- self-hosted open-source web analytics (Google Analytics alternative)"
        category "analytics"

        def gems
          []
        end

        def template_lines
          [
            'create_file "app/views/layouts/_matomo.html.erb", <<~ERB',
            "  <script>",
            "    var _paq = window._paq = window._paq || [];",
            '    _paq.push(["trackPageView"]);',
            '    _paq.push(["enableLinkTracking"]);',
            "    (function() {",
            '      var u="<%%= Rails.application.credentials.dig(:matomo, :url) || ENV["MATOMO_URL"] %>/";',
            '      _paq.push(["setTrackerUrl", u+"matomo.php"]);',
            '      _paq.push(["setSiteId", "<%%= Rails.application.credentials.dig(:matomo, :site_id) || ENV["MATOMO_SITE_ID"] %>"]);',
            '      var d=document, g=d.createElement("script"), s=d.getElementsByTagName("script")[0];',
            '      g.async=true; g.src=u+"matomo.js"; s.parentNode.insertBefore(g,s);',
            "    })();",
            "  </script>",
            "ERB",
            "",
            'inject_into_file "app/views/layouts/application.html.erb", after: "<head>\\n" do',
            '  "    <%= render \\"layouts/matomo\\" %>\\n"',
            "end"
          ]
        end

        def post_install_notes
          [
            "Matomo: Add your instance details with `bin/rails credentials:edit`:",
            "  matomo:",
            "    url: https://your-matomo-instance.com",
            "    site_id: 1",
            "Matomo: Self-hosted -- you own 100% of your analytics data"
          ]
        end
      end
    end
  end
end
