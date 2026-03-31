module Rails
  module Metro
    module Packs
      class ChartingPack < FeaturePack
        pack_name "charting"
        description "Chartkick + Groupdate for charts and time-series visualization"
        category "ui"

        def gems
          [
            {name: "chartkick", version: "~> 5.2"},
            {name: "groupdate", version: "~> 6.0"}
          ]
        end

        def template_lines
          [
            importmap_lines,
            layout_js_lines,
            sample_partial_lines
          ].flatten
        end

        def post_install_notes
          [
            "Charting: Use `<%= line_chart User.group_by_day(:created_at).count %>` in views",
            "Charting: Groupdate adds `.group_by_day`, `.group_by_week`, etc. to ActiveRecord",
            "Charting: See https://chartkick.com for full documentation"
          ]
        end

        private

        def importmap_lines
          [
            "# Pin Chartkick JS for importmap-rails",
            'append_to_file "config/importmap.rb", <<~RUBY',
            '  pin "chartkick", to: "chartkick.js"',
            '  pin "Chart.bundle", to: "Chart.bundle.js"',
            "RUBY"
          ]
        end

        def layout_js_lines
          [
            'inject_into_file "app/views/layouts/application.html.erb", before: "</head>" do',
            '  "    <%= javascript_include_tag \\"chartkick\\" %>\\n"',
            "end"
          ]
        end

        def sample_partial_lines
          [
            'create_file "app/views/shared/_sample_chart.html.erb", <<~ERB',
            "  <%# Example charts -- remove or customize %>",
            "  <div class=\"charts\">",
            "    <h2>Sample Charts</h2>",
            '    <%%= line_chart({"Jan" => 100, "Feb" => 150, "Mar" => 200}, title: "Monthly Growth") %>',
            '    <%%= pie_chart({"Ruby" => 40, "JavaScript" => 30, "Python" => 20, "Other" => 10}, title: "Languages") %>',
            "  </div>",
            "ERB"
          ]
        end
      end
    end
  end
end
