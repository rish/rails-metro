module Rails
  module Metro
    module Packs
      class SimplecovPack < FeaturePack
        pack_name "simplecov"
        description "SimpleCov for code coverage reporting"
        category "testing"

        def gems
          [
            {name: "simplecov", group: :test}
          ]
        end

        def template_lines
          [
            'prepend_to_file "test/test_helper.rb", <<~RUBY',
            '  require "simplecov"',
            "  SimpleCov.start \"rails\" do",
            '    add_filter "/test/"',
            '    add_filter "/config/"',
            "    enable_coverage :branch",
            "  end",
            "",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "SimpleCov: Coverage report generated at coverage/index.html after running tests",
            "SimpleCov: Branch coverage enabled by default"
          ]
        end
      end
    end
  end
end
