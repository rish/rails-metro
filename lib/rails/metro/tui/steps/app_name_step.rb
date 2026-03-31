module Rails
  module Metro
    module Tui
      module Steps
        class AppNameStep
          attr_reader :app_name, :error

          def initialize(app_name: "")
            @app_name = app_name
            @error = nil
          end

          def update(msg)
            case msg
            when Bubbletea::KeyMessage
              if msg.enter?
                if @app_name.strip.empty?
                  @error = "App name cannot be empty"
                elsif @app_name.match?(/[^a-zA-Z0-9_-]/)
                  @error = "App name can only contain letters, numbers, hyphens, and underscores"
                else
                  @error = nil
                  return self, :next
                end
              elsif msg.backspace?
                @app_name = @app_name[0...-1]
                @error = nil
              elsif msg.runes?
                @app_name += msg.to_s
                @error = nil
              end
            end
            [self, nil]
          end

          def view
            lines = []
            lines << Styles.title.render("  Create a new Rails app")
            lines << ""
            lines << "  App name: #{@app_name}█"
            lines << ""
            if @error
              lines << "  #{Styles.error_style.render(@error)}"
              lines << ""
            end
            lines << Styles.help.render("  Enter to continue • Ctrl+C to quit")
            lines.join("\n")
          end

          def complete?
            @app_name.strip.length > 0 && @error.nil?
          end
        end
      end
    end
  end
end
