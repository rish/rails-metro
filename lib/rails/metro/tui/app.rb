module Rails
  module Metro
    module Tui
      class App
        include Bubbletea::Model

        STEP_ORDER = %i[app_name database packs review].freeze

        attr_reader :step_index, :config, :steps

        def initialize
          @config = Config.new
          @registry = FeatureRegistry.default
          @step_index = 0
          @steps = {
            app_name: Steps::AppNameStep.new,
            database: Steps::DatabaseStep.new,
            packs: Steps::PackStep.new(registry: @registry),
            review: nil
          }
          @quitting = false
          @final_action = nil
        end

        def init
          nil
        end

        def update(msg)
          case msg
          when Bubbletea::KeyMessage
            if msg.esc? || (msg.ctrl? && msg.char == "c")
              @quitting = true
              return self, Bubbletea::QuitCommand.new
            end
          end

          step = current_step
          step, action = step.update(msg)
          @steps[current_step_name] = step

          case action
          when :next
            advance_step
          when :back
            go_back
          end

          [self, nil]
        end

        def view
          return "" if @quitting

          lines = []
          lines << header
          lines << ""
          lines << current_step.view
          lines.join("\n")
        end

        def current_step_name
          STEP_ORDER[@step_index]
        end

        def current_step
          @steps[current_step_name]
        end

        attr_reader :final_action

        private

        def header
          progress = STEP_ORDER.each_with_index.map { |name, i|
            label = name.to_s.tr("_", " ").capitalize
            if i < @step_index
              Styles.success.render("✓ #{label}")
            elsif i == @step_index
              Styles.selected.render("● #{label}")
            else
              Styles.dimmed.render("○ #{label}")
            end
          }.join("  ")
          "  #{progress}"
        end

        def advance_step
          sync_config

          if @step_index >= STEP_ORDER.length - 1
            @final_action = @steps[:review]&.action
            @quitting = true
            return self, Bubbletea::QuitCommand.new
          end

          @step_index += 1

          if current_step_name == :review
            @steps[:review] = Steps::ReviewStep.new(config: @config, registry: @registry)
          end

          [self, nil]
        end

        def go_back
          @step_index = [@step_index - 1, 0].max
          [self, nil]
        end

        def sync_config
          @config.app_name = @steps[:app_name].app_name
          @config.database = @steps[:database].selected
          @config.selected_packs = @steps[:packs].selected_packs.to_a.sort
        end
      end
    end
  end
end
