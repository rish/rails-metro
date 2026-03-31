module Rails
  module Metro
    module Packs
      class FathomPack < FeaturePack
        pack_name "fathom"
        description "Fathom -- simple, privacy-focused website analytics"
        category "analytics"

        def gems
          []
        end

        def template_lines
          [
            'create_file "app/views/layouts/_fathom.html.erb", <<~ERB',
            '  <script src="https://cdn.usefathom.com/script.js" data-site="<%%= Rails.application.credentials.dig(:fathom, :site_id) || ENV["FATHOM_SITE_ID"] %>" defer></script>',
            "ERB",
            "",
            'inject_into_file "app/views/layouts/application.html.erb", after: "<head>\\n" do',
            '  "    <%= render \\"layouts/fathom\\" %>\\n"',
            "end"
          ]
        end

        def post_install_notes
          [
            "Fathom: Add your site ID with `bin/rails credentials:edit`:",
            "  fathom:",
            "    site_id: ABCDEFGH",
            "Fathom: No cookie banner needed -- privacy-first, GDPR compliant"
          ]
        end
      end
    end
  end
end
