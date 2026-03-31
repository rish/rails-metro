module Rails
  module Metro
    module Tui
      module Styles
        def self.title
          @title ||= Lipgloss::Style.new.foreground("205").bold(true)
        end

        def self.subtitle
          @subtitle ||= Lipgloss::Style.new.foreground("245")
        end

        def self.selected
          @selected ||= Lipgloss::Style.new.foreground("205").bold(true)
        end

        def self.cursor
          @cursor ||= Lipgloss::Style.new.foreground("205")
        end

        def self.dimmed
          @dimmed ||= Lipgloss::Style.new.foreground("241")
        end

        def self.category_header
          @category_header ||= Lipgloss::Style.new.foreground("111").bold(true)
        end

        def self.error_style
          @error_style ||= Lipgloss::Style.new.foreground("196").bold(true)
        end

        def self.success
          @success ||= Lipgloss::Style.new.foreground("82").bold(true)
        end

        def self.help
          @help ||= Lipgloss::Style.new.foreground("241")
        end

        def self.status_bar
          @status_bar ||= Lipgloss::Style.new.foreground("255").background("236").padding(0, 1)
        end
      end
    end
  end
end
