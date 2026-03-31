require "test_helper"

class Rails::Metro::ConfigTest < Minitest::Test
  def test_defaults
    config = Rails::Metro::Config.new
    assert_nil config.app_name
    assert_equal "sqlite3", config.database
    assert_equal [], config.selected_packs
    assert_equal "", config.rails_args
  end

  def test_custom_values
    config = Rails::Metro::Config.new(
      app_name: "myapp",
      database: "postgresql",
      selected_packs: ["posthog", "blazer"],
      rails_args: "--skip-test"
    )
    assert_equal "myapp", config.app_name
    assert_equal "postgresql", config.database
    assert_equal ["posthog", "blazer"], config.selected_packs
    assert_equal "--skip-test", config.rails_args
  end

  def test_yaml_round_trip
    config = Rails::Metro::Config.new(
      app_name: "myapp",
      database: "postgresql",
      selected_packs: ["posthog", "charting"]
    )
    yaml = config.to_yaml
    restored = Rails::Metro::Config.from_yaml(yaml)

    assert_equal "myapp", restored.app_name
    assert_equal "postgresql", restored.database
    assert_equal ["posthog", "charting"], restored.selected_packs
  end

  def test_summary
    config = Rails::Metro::Config.new(app_name: "myapp", selected_packs: ["posthog", "blazer"])
    assert_equal "myapp (sqlite3) packs: posthog, blazer", config.summary
  end

  def test_summary_no_packs
    config = Rails::Metro::Config.new(app_name: "myapp")
    assert_equal "myapp (sqlite3) packs: none", config.summary
  end
end
