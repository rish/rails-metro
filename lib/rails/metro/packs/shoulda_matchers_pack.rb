module Rails
  module Metro
    module Packs
      class ShouldaMatchersPack < FeaturePack
        pack_name "shoulda_matchers"
        description "Shoulda Matchers for one-liner model and controller test assertions"
        category "testing"

        def gems
          [
            {name: "shoulda-matchers", group: :test}
          ]
        end

        def template_lines
          [
            'create_file "test/support/shoulda_matchers.rb", <<~RUBY',
            "  Shoulda::Matchers.configure do |config|",
            "    config.integrate do |with|",
            "      with.test_framework :minitest",
            "      with.library :rails",
            "    end",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Shoulda: Use `should validate_presence_of(:name)` in model tests",
            "Shoulda: Use `should belong_to(:user)` for association tests"
          ]
        end
      end
    end
  end
end
