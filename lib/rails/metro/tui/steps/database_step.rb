module Rails
  module Metro
    module Tui
      module Steps
        class DatabaseStep
          DATABASES = %w[sqlite3 postgresql mysql2].freeze

          attr_reader :cursor, :selected

          def initialize(selected: "sqlite3")
            @cursor = DATABASES.index(selected) || 0
            @selected = selected
          end

          def update(msg)
            case msg
            when Bubbletea::KeyMessage
              if msg.enter?
                @selected = DATABASES[@cursor]
                return self, :next
              elsif msg.up? || msg.char == "k"
                @cursor = (@cursor - 1) % DATABASES.length
              elsif msg.down? || msg.char == "j"
                @cursor = (@cursor + 1) % DATABASES.length
              end
            end
            [self, nil]
          end

          def view
            lines = []
            lines << Styles.title.render("  Select database")
            lines << ""
            DATABASES.each_with_index do |db, i|
              lines << if i == @cursor
                Styles.selected.render("  > #{db}")
              else
                Styles.dimmed.render("    #{db}")
              end
            end
            lines << ""
            lines << Styles.help.render("  j/k or arrows to move • Enter to select • Ctrl+C to quit")
            lines.join("\n")
          end

          def complete?
            DATABASES.include?(@selected)
          end
        end
      end
    end
  end
end
