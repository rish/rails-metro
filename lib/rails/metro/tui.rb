module Rails
  module Metro
    module Tui
      def self.available?
        require "bubbletea"
        require "lipgloss"
        true
      rescue LoadError
        false
      end

      def self.require_dependencies!
        require "bubbletea"
        require "lipgloss"
        require_relative "tui/styles"
        require_relative "tui/steps/app_name_step"
        require_relative "tui/steps/database_step"
        require_relative "tui/steps/pack_step"
        require_relative "tui/steps/review_step"
        require_relative "tui/app"
      end

      def self.run
        require_dependencies!
        app = App.new
        runner = Bubbletea::Runner.new(app, alt_screen: true)
        runner.run

        [app.config, app.final_action]
      rescue LoadError
        warn "TUI requires the bubbletea gem. Install it with:"
        warn "  gem install bubbletea"
        exit 1
      end
    end
  end
end
