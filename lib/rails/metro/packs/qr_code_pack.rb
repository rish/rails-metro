module Rails
  module Metro
    module Packs
      class QrCodePack < FeaturePack
        pack_name "qr_code"
        description "RQRCode for QR code generation (SVG, PNG, ANSI)"
        category "ui"

        def gems
          [
            {name: "rqrcode"}
          ]
        end

        def template_lines
          [
            'create_file "app/helpers/qr_code_helper.rb", <<~RUBY',
            "  module QrCodeHelper",
            '    def qr_code_svg(content, size: 4, color: "000")',
            "      qr = RQRCode::QRCode.new(content)",
            '      qr.as_svg(module_size: size, color: color, shape_rendering: "crispEdges").html_safe',
            "    end",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "QR Code: Use `<%= qr_code_svg(\"https://example.com\") %>` in views",
            "QR Code: Also supports PNG with `qr.as_png` and ANSI terminal output"
          ]
        end
      end
    end
  end
end
