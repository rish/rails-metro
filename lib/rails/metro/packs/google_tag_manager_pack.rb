module Rails
  module Metro
    module Packs
      class GoogleTagManagerPack < FeaturePack
        pack_name "google_tag_manager"
        description "Google Tag Manager for managing analytics and marketing tags"
        category "analytics"

        def gems
          []
        end

        def template_lines
          [
            'create_file "app/views/layouts/_gtm_head.html.erb", <<~ERB',
            "  <!-- Google Tag Manager -->",
            "  <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\"gtm.start\":",
            '  new Date().getTime(),event:"gtm.js"});var f=d.getElementsByTagName(s)[0],',
            '  j=d.createElement(s),dl=l!="dataLayer"?"&l="+l:"";j.async=true;j.src=',
            '  "https://www.googletagmanager.com/gtm.js?id="+i+dl;f.parentNode.insertBefore(j,f);',
            '  })(window,document,"script","dataLayer","<%%= Rails.application.credentials.dig(:gtm, :container_id) || ENV["GTM_CONTAINER_ID"] %>");</script>',
            "ERB",
            "",
            'create_file "app/views/layouts/_gtm_body.html.erb", <<~ERB',
            "  <!-- Google Tag Manager (noscript) -->",
            '  <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=<%%= Rails.application.credentials.dig(:gtm, :container_id) || ENV["GTM_CONTAINER_ID"] %>"',
            '  height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>',
            "ERB",
            "",
            'inject_into_file "app/views/layouts/application.html.erb", after: "<head>\\n" do',
            '  "    <%= render \\"layouts/gtm_head\\" %>\\n"',
            "end",
            "",
            'inject_into_file "app/views/layouts/application.html.erb", after: "<body>\\n" do',
            '  "    <%= render \\"layouts/gtm_body\\" %>\\n"',
            "end"
          ]
        end

        def post_install_notes
          [
            "GTM: Add your container ID with `bin/rails credentials:edit`:",
            "  gtm:",
            "    container_id: GTM-XXXXXXX",
            "GTM: Manage all your analytics/marketing tags from the GTM dashboard"
          ]
        end
      end
    end
  end
end
