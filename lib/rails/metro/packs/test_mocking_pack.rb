module Rails
  module Metro
    module Packs
      class TestMockingPack < FeaturePack
        pack_name "test_mocking"
        description "VCR + WebMock for recording and replaying HTTP interactions in tests"
        category "testing"

        def gems
          [
            {name: "vcr", group: :test},
            {name: "webmock", group: :test}
          ]
        end

        def template_lines
          [
            'create_file "test/support/vcr.rb", <<~RUBY',
            '  require "vcr"',
            "",
            "  VCR.configure do |config|",
            '    config.cassette_library_dir = "test/cassettes"',
            "    config.hook_into :webmock",
            "    config.ignore_localhost = true",
            "    config.default_cassette_options = { record: :once }",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "VCR: Wrap HTTP tests with `VCR.use_cassette(\"name\") { }` to record/replay",
            "VCR: Cassettes stored in test/cassettes/",
            "WebMock: All external HTTP is blocked in tests by default -- use VCR or stub explicitly"
          ]
        end
      end
    end
  end
end
