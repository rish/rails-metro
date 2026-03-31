require "test_helper"
require "rails/metro/tui"

Rails::Metro::Tui.require_dependencies!

# Key type constants for Bubbletea::KeyMessage
KEY_RUNES = -1
KEY_UP = -2
KEY_DOWN = -3
KEY_RIGHT = -4
KEY_LEFT = -5
KEY_SPACE = -25
KEY_TAB = 9
KEY_ENTER = 13
KEY_ESC = 27
KEY_BACKSPACE = 127

def make_key(enter: false, backspace: false, esc: false, char: nil,
  up: false, down: false, tab: false, space: false, ctrl: false)
  if enter
    Bubbletea::KeyMessage.new(key_type: KEY_ENTER)
  elsif backspace
    Bubbletea::KeyMessage.new(key_type: KEY_BACKSPACE)
  elsif esc
    Bubbletea::KeyMessage.new(key_type: KEY_ESC)
  elsif up
    Bubbletea::KeyMessage.new(key_type: KEY_UP)
  elsif down
    Bubbletea::KeyMessage.new(key_type: KEY_DOWN)
  elsif tab
    Bubbletea::KeyMessage.new(key_type: KEY_TAB)
  elsif space
    Bubbletea::KeyMessage.new(key_type: KEY_SPACE)
  elsif char
    Bubbletea::KeyMessage.new(key_type: KEY_RUNES, runes: char.codepoints)
  else
    Bubbletea::KeyMessage.new(key_type: 0)
  end
end

def type_chars(step, str)
  str.each_char { |c| step.update(make_key(char: c)) }
end

class Rails::Metro::Tui::AppNameStepTest < Minitest::Test
  def setup
    @step = Rails::Metro::Tui::Steps::AppNameStep.new
  end

  def test_initial_state
    assert_equal "", @step.app_name
    refute @step.complete?
  end

  def test_typing_sets_app_name
    type_chars(@step, "myapp")
    assert_equal "myapp", @step.app_name
  end

  def test_backspace_removes_character
    type_chars(@step, "myapp")
    @step.update(make_key(backspace: true))
    assert_equal "myap", @step.app_name
  end

  def test_enter_with_empty_name_shows_error
    _, action = @step.update(make_key(enter: true))
    assert_nil action
    assert @step.error
  end

  def test_enter_with_valid_name_advances
    type_chars(@step, "myapp")
    _, action = @step.update(make_key(enter: true))
    assert_equal :next, action
    assert @step.complete?
  end

  def test_enter_with_invalid_chars_shows_error
    type_chars(@step, "my app!")
    _, action = @step.update(make_key(enter: true))
    assert_nil action
    assert @step.error
  end

  def test_view_contains_app_name
    type_chars(@step, "testapp")
    assert_includes @step.view, "testapp"
  end
end

class Rails::Metro::Tui::DatabaseStepTest < Minitest::Test
  def setup
    @step = Rails::Metro::Tui::Steps::DatabaseStep.new
  end

  def test_initial_state
    assert_equal 0, @step.cursor
    assert_equal "sqlite3", @step.selected
  end

  def test_move_down
    @step.update(make_key(char: "j"))
    assert_equal 1, @step.cursor
  end

  def test_move_up_wraps
    @step.update(make_key(char: "k"))
    assert_equal 2, @step.cursor
  end

  def test_enter_selects_and_advances
    @step.update(make_key(char: "j"))
    _, action = @step.update(make_key(enter: true))
    assert_equal :next, action
    assert_equal "postgresql", @step.selected
  end

  def test_view_shows_databases
    view = @step.view
    assert_includes view, "sqlite3"
    assert_includes view, "postgresql"
    assert_includes view, "mysql2"
  end
end

class Rails::Metro::Tui::PackStepTest < Minitest::Test
  def setup
    @registry = Rails::Metro::FeatureRegistry.default
    @step = Rails::Metro::Tui::Steps::PackStep.new(registry: @registry)
  end

  def test_initial_state
    assert_empty @step.selected_packs
    assert @step.complete?
  end

  def test_search_mode
    @step.update(make_key(char: "/"))
    assert @step.searching
  end

  def test_search_and_escape
    @step.update(make_key(char: "/"))
    type_chars(@step, "post")
    assert_equal "post", @step.search_query
    @step.update(make_key(esc: true))
    refute @step.searching
  end

  def test_view_shows_title
    assert_includes @step.view, "Select feature packs"
  end

  def test_enter_advances
    _, action = @step.update(make_key(enter: true))
    assert_equal :next, action
  end
end

class Rails::Metro::Tui::ReviewStepTest < Minitest::Test
  def setup
    config = Rails::Metro::Config.new(
      app_name: "testapp",
      database: "postgresql",
      selected_packs: ["posthog"]
    )
    @step = Rails::Metro::Tui::Steps::ReviewStep.new(config: config)
  end

  def test_initial_state
    assert_nil @step.action
    refute @step.complete?
  end

  def test_view_shows_config
    view = @step.view
    assert_includes view, "testapp"
    assert_includes view, "postgresql"
    assert_includes view, "posthog"
  end

  def test_generate_shortcut
    _, action = @step.update(make_key(char: "g"))
    assert_equal :next, action
    assert_equal "g", @step.action
  end

  def test_export_config_shortcut
    _, action = @step.update(make_key(char: "e"))
    assert_equal :next, action
    assert_equal "e", @step.action
  end

  def test_back_shortcut
    _, action = @step.update(make_key(char: "b"))
    assert_equal :back, action
    assert_equal "b", @step.action
  end
end
