module Rails
  module Metro
    module Packs
      class SeoPack < FeaturePack
        pack_name "seo"
        description "meta-tags + sitemap_generator for SEO"
        category "seo"

        def gems
          [
            {name: "meta-tags", version: "~> 2.22"},
            {name: "sitemap_generator", version: "~> 6.3"}
          ]
        end

        def template_lines
          [
            'create_file "config/sitemap.rb", <<~RUBY',
            '  SitemapGenerator::Sitemap.default_host = "https://example.com"',
            "",
            "  SitemapGenerator::Sitemap.create do",
            '    add "/about", changefreq: "monthly"',
            "  end",
            "RUBY",
            'inject_into_file "app/views/layouts/application.html.erb", after: "<head>\\n" do',
            '  "    <%= display_meta_tags site: \\"My App\\" %>\\n"',
            "end"
          ]
        end

        def post_install_notes
          [
            "SEO: Use `set_meta_tags title: \"Page\"` in controllers",
            "SEO: Generate sitemap with `bin/rails sitemap:refresh`"
          ]
        end
      end
    end
  end
end
