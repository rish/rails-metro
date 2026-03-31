module Rails
  module Metro
    module Packs
      class SpreadsheetsPack < FeaturePack
        pack_name "spreadsheets"
        description "Caxlsx for Excel spreadsheet generation"
        category "ui"

        def gems
          [
            {name: "caxlsx"},
            {name: "caxlsx_rails"}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "Spreadsheets: Create .xlsx templates in app/views with `.xlsx.axlsx` extension",
            "Spreadsheets: Use `format.xlsx` in controllers to serve Excel downloads"
          ]
        end
      end
    end
  end
end
