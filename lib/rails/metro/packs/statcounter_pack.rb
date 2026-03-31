module Rails
  module Metro
    module Packs
      class StatcounterPack < FeaturePack
        pack_name "statcounter"
        description "StatCounter for visitor stats and web analytics"
        category "analytics"

        def gems
          []
        end

        def template_lines
          [
            'create_file "app/views/layouts/_statcounter.html.erb", <<~ERB',
            "  <script type=\"text/javascript\">",
            "    var sc_project=<%%= Rails.application.credentials.dig(:statcounter, :project_id) || ENV[\"STATCOUNTER_PROJECT_ID\"] %>;",
            "    var sc_invisible=1;",
            "    var sc_security=\"<%%= Rails.application.credentials.dig(:statcounter, :security_code) || ENV[\"STATCOUNTER_SECURITY\"] %>\";",
            "  </script>",
            '  <script type="text/javascript" src="https://www.statcounter.com/counter/counter.js" async></script>',
            "ERB",
            "",
            'inject_into_file "app/views/layouts/application.html.erb", before: "</body>" do',
            '  "    <%= render \\"layouts/statcounter\\" %>\\n"',
            "end"
          ]
        end

        def post_install_notes
          [
            "StatCounter: Add your project credentials with `bin/rails credentials:edit`:",
            "  statcounter:",
            "    project_id: 12345678",
            "    security_code: your_security_code"
          ]
        end
      end
    end
  end
end
