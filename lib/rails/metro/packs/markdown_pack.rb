module Rails
  module Metro
    module Packs
      class MarkdownPack < FeaturePack
        pack_name "markdown"
        description "Redcarpet for Markdown rendering with syntax highlighting"
        category "ui"

        def gems
          [
            {name: "redcarpet"},
            {name: "rouge"}
          ]
        end

        def template_lines
          [
            'create_file "app/helpers/markdown_helper.rb", <<~RUBY',
            "  module MarkdownHelper",
            "    def render_markdown(text)",
            "      renderer = Redcarpet::Render::HTML.new(",
            "        hard_wrap: true,",
            "        link_attributes: { target: \"_blank\", rel: \"noopener\" }",
            "      )",
            "      markdown = Redcarpet::Markdown.new(renderer,",
            "        autolink: true,",
            "        tables: true,",
            "        fenced_code_blocks: true,",
            "        strikethrough: true,",
            "        highlight: true",
            "      )",
            "      markdown.render(text).html_safe",
            "    end",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Markdown: Use `<%= render_markdown(@post.body) %>` in views",
            "Markdown: Rouge provides syntax highlighting for code blocks"
          ]
        end
      end
    end
  end
end
