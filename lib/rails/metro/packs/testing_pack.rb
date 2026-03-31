module Rails
  module Metro
    module Packs
      class TestingPack < FeaturePack
        pack_name "testing"
        description "FactoryBot + Faker + Capybara for testing"
        category "testing"

        def gems
          [
            {name: "factory_bot_rails", group: :test},
            {name: "faker", group: :test},
            {name: "capybara", group: :test},
            {name: "selenium-webdriver", group: :test}
          ]
        end

        def template_lines
          [
            'create_file "test/support/factory_bot.rb", <<~RUBY',
            "  FactoryBot::SyntaxMethods",
            "",
            "  class ActiveSupport::TestCase",
            "    include FactoryBot::Syntax::Methods",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Testing: Generate factories with `bin/rails g factory_bot:model User`",
            "Testing: Use `build(:user)`, `create(:user)` in tests"
          ]
        end
      end
    end
  end
end
