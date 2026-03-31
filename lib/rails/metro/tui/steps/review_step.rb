module Rails
  module Metro
    module Tui
      module Steps
        class ReviewStep
          attr_reader :action

          def initialize(config:, registry: nil)
            @config = config
            @registry = registry || FeatureRegistry.default
            @action = nil
            @cursor = 0
          end

          ACTIONS = [
            {key: "g", label: "Generate app (runs rails new)"},
            {key: "e", label: "Export metro.yml config"},
            {key: "t", label: "Export template.rb only"},
            {key: "b", label: "Go back"}
          ].freeze

          def update(msg)
            case msg
            when Bubbletea::KeyMessage
              if msg.enter?
                @action = ACTIONS[@cursor][:key]
                return self, :next if @action != "b"
                return self, :back
              elsif msg.up? || msg.char == "k"
                @cursor = (@cursor - 1) % ACTIONS.length
              elsif msg.down? || msg.char == "j"
                @cursor = (@cursor + 1) % ACTIONS.length
              elsif msg.char == "g"
                @action = "g"
                return self, :next
              elsif msg.char == "e"
                @action = "e"
                return self, :next
              elsif msg.char == "t"
                @action = "t"
                return self, :next
              elsif msg.char == "b"
                @action = "b"
                return self, :back
              end
            end
            [self, nil]
          end

          def view
            lines = []
            lines << Styles.title.render("  Review your configuration")
            lines << ""
            lines << "  App name:  #{Styles.selected.render(@config.app_name)}"
            lines << "  Database:  #{@config.database}"
            lines << "  Packs:     #{pack_summary}"
            lines << ""

            if @config.selected_packs.any?
              lines << Styles.category_header.render("  Selected packs:")
              @config.selected_packs.sort.each do |name|
                lines << "    • #{name}"
              end
              lines << ""
            end

            lines << Styles.category_header.render("  Actions:")
            ACTIONS.each_with_index do |action, i|
              lines << if i == @cursor
                Styles.selected.render("  > [#{action[:key]}] #{action[:label]}")
              else
                "    [#{action[:key]}] #{action[:label]}"
              end
            end
            lines << ""
            lines << Styles.help.render("  j/k to move • Enter or key shortcut to select")
            lines.join("\n")
          end

          def complete?
            !@action.nil? && @action != "b"
          end

          private

          def pack_summary
            count = @config.selected_packs.length
            (count == 0) ? "none" : "#{count} selected"
          end
        end
      end
    end
  end
end
