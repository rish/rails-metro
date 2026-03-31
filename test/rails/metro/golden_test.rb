require "test_helper"

class Rails::Metro::GoldenTest < Minitest::Test
  GOLDEN_DIR = File.expand_path("../../golden", __dir__)

  Dir.glob(File.join(GOLDEN_DIR, "inputs", "*.yml")).sort.each do |input_file|
    name = File.basename(input_file, ".yml")

    define_method("test_golden_#{name}") do
      yaml = File.read(input_file)
      config = Rails::Metro::Config.from_yaml(yaml)
      registry = Rails::Metro::FeatureRegistry.default

      packs = if config.selected_packs.empty?
        []
      else
        registry.resolve(config.selected_packs)
      end

      compiler = Rails::Metro::TemplateCompiler.new(config: config, packs: packs)
      actual = compiler.compile

      expected_path = File.join(GOLDEN_DIR, "expected", "#{name}_template.rb")
      expected = File.read(expected_path)

      assert_equal expected, actual,
        "Golden file mismatch for #{name}. If intentional, regenerate with:\n" \
        "  bundle exec ruby -e 'require \"rails/metro\"; " \
        "c = Rails::Metro::Config.from_yaml(File.read(\"#{input_file}\")); " \
        "r = Rails::Metro::FeatureRegistry.default; " \
        "p = c.selected_packs.empty? ? [] : r.resolve(c.selected_packs); " \
        "puts Rails::Metro::TemplateCompiler.new(config: c, packs: p).compile' > #{expected_path}"
    end
  end

  def test_template_output_is_deterministic
    yaml = File.read(File.join(GOLDEN_DIR, "inputs", "saas_starter.yml"))
    config = Rails::Metro::Config.from_yaml(yaml)
    registry = Rails::Metro::FeatureRegistry.default
    packs = registry.resolve(config.selected_packs)

    results = 3.times.map do
      Rails::Metro::TemplateCompiler.new(config: config, packs: packs).compile
    end

    assert_equal results[0], results[1]
    assert_equal results[1], results[2]
  end
end
