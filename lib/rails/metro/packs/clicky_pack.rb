module Rails
  module Metro
    module Packs
      class ClickyPack < FeaturePack
        pack_name "clicky"
        description "Clicky for real-time web analytics"
        category "analytics"

        def gems
          []
        end

        def template_lines
          [
            'create_file "app/views/layouts/_clicky.html.erb", <<~ERB',
            "  <script>var clicky_site_ids = clicky_site_ids || []; clicky_site_ids.push(<%%= Rails.application.credentials.dig(:clicky, :site_id) || ENV[\"CLICKY_SITE_ID\"] %>);</script>",
            '  <script async src="//static.getclicky.com/js"></script>',
            '  <noscript><p><img alt="Clicky" width="1" height="1" src="//in.getclicky.com/<%%= Rails.application.credentials.dig(:clicky, :site_id) || ENV["CLICKY_SITE_ID"] %>ns.gif" /></p></noscript>',
            "ERB",
            "",
            'inject_into_file "app/views/layouts/application.html.erb", before: "</body>" do',
            '  "    <%= render \\"layouts/clicky\\" %>\\n"',
            "end"
          ]
        end

        def post_install_notes
          [
            "Clicky: Add your site ID with `bin/rails credentials:edit`:",
            "  clicky:",
            "    site_id: 123456"
          ]
        end
      end
    end
  end
end
