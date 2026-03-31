module Rails
  module Metro
    module Packs
      class PdfPack < FeaturePack
        pack_name "pdf"
        description "Grover for PDF generation from HTML (Puppeteer-based)"
        category "ui"

        def gems
          [
            {name: "grover"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/grover.rb", <<~RUBY',
            "  Grover.configure do |config|",
            "    config.options = {",
            '      format: "A4",',
            "      margin: {",
            '        top: "1cm",',
            '        bottom: "1cm",',
            '        left: "1cm",',
            '        right: "1cm"',
            "      },",
            "      prefer_css_page_size: true,",
            "      print_background: true",
            "    }",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "PDF: Requires Node.js and Puppeteer (`npm i puppeteer`)",
            "PDF: Use `Grover.new(html_string).to_pdf` to generate PDFs",
            "PDF: Or use as Rack middleware to serve .pdf versions of any page"
          ]
        end
      end
    end
  end
end
