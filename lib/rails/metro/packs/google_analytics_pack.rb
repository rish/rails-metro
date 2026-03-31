module Rails
  module Metro
    module Packs
      class GoogleAnalyticsPack < FeaturePack
        pack_name "google_analytics"
        description "Google Analytics 4 (GA4) for web analytics"
        category "analytics"

        def gems
          []
        end

        def template_lines
          [
            'create_file "app/views/layouts/_google_analytics.html.erb", <<~ERB',
            "  <!-- Google Analytics 4 -->",
            '  <script async src="https://www.googletagmanager.com/gtag/js?id=<%%= Rails.application.credentials.dig(:google_analytics, :measurement_id) || ENV["GA_MEASUREMENT_ID"] %>"></script>',
            "  <script>",
            "    window.dataLayer = window.dataLayer || [];",
            "    function gtag(){dataLayer.push(arguments);}",
            '    gtag("js", new Date());',
            '    gtag("config", "<%%= Rails.application.credentials.dig(:google_analytics, :measurement_id) || ENV["GA_MEASUREMENT_ID"] %>");',
            "  </script>",
            "ERB",
            "",
            'inject_into_file "app/views/layouts/application.html.erb", after: "<head>\\n" do',
            '  "    <%= render \\"layouts/google_analytics\\" %>\\n"',
            "end"
          ]
        end

        def post_install_notes
          [
            "Google Analytics: Add your measurement ID with `bin/rails credentials:edit`:",
            "  google_analytics:",
            "    measurement_id: G-XXXXXXXXXX"
          ]
        end
      end
    end
  end
end
