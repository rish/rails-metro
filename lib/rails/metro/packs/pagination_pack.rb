module Rails
  module Metro
    module Packs
      class PaginationPack < FeaturePack
        pack_name "pagination"
        description "Pagy for fast, lightweight pagination"
        category "ui"

        def gems
          [
            {name: "pagy", version: "~> 9.0"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/pagy.rb", <<~RUBY',
            '  require "pagy/extras/overflow"',
            '  require "pagy/extras/metadata"',
            "",
            "  Pagy::DEFAULT[:limit] = 25",
            "  Pagy::DEFAULT[:overflow] = :last_page",
            "RUBY",
            "",
            'inject_into_file "app/controllers/application_controller.rb", after: "class ApplicationController < ActionController::Base\\n" do',
            '  "  include Pagy::Backend\\n"',
            "end",
            "",
            'inject_into_file "app/helpers/application_helper.rb", after: "module ApplicationHelper\\n" do',
            '  "  include Pagy::Frontend\\n"',
            "end"
          ]
        end

        def post_install_notes
          [
            "Pagy: Use `@pagy, @records = pagy(User.all)` in controllers",
            "Pagy: Use `<%%= pagy_nav(@pagy) %>` in views"
          ]
        end
      end
    end
  end
end
