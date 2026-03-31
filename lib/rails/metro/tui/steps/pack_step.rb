module Rails
  module Metro
    module Tui
      module Steps
        class PackStep
          attr_reader :selected_packs, :cursor, :category_cursor, :search_query,
            :searching, :error

          def initialize(registry: nil)
            @registry = registry || FeatureRegistry.default
            @categories = build_categories
            @category_cursor = 0
            @cursor = 0
            @selected_packs = Set.new
            @searching = false
            @search_query = ""
            @error = nil
            @pane = :categories
          end

          def update(msg)
            case msg
            when Bubbletea::KeyMessage
              return handle_search_key(msg) if @searching
              return handle_key(msg)
            end
            [self, nil]
          end

          def view
            lines = []
            lines << Styles.title.render("  Select feature packs")
            lines << ""

            if @searching
              lines << "  Search: #{@search_query}█"
              lines << ""
              lines.concat(search_results_view)
            elsif @pane == :categories
              lines.concat(categories_view)
            else
              lines.concat(packs_view)
            end

            lines << ""
            if @error
              lines << "  #{Styles.error_style.render(@error)}"
              lines << ""
            end
            lines << status_line
            lines << help_line
            lines.join("\n")
          end

          def complete?
            true
          end

          private

          def build_categories
            catalog = @registry.as_catalog
            grouped = catalog.group_by { |p| p[:category] }
            grouped.sort_by { |cat, _| cat }.map { |cat, packs|
              {name: cat, packs: packs.sort_by { |p| p[:name] }}
            }
          end

          def current_category
            @categories[@category_cursor]
          end

          def current_packs
            current_category[:packs]
          end

          def handle_key(msg)
            if msg.enter?
              return self, :next
            elsif msg.char == "/"
              @searching = true
              @search_query = ""
              @error = nil
            elsif msg.tab?
              toggle_pane
            elsif msg.space?
              toggle_pack if @pane == :packs
            elsif msg.up? || msg.char == "k"
              move_up
            elsif msg.down? || msg.char == "j"
              move_down
            end
            [self, nil]
          end

          def handle_search_key(msg)
            if msg.esc?
              @searching = false
              @search_query = ""
            elsif msg.enter?
              toggle_search_result
            elsif msg.backspace?
              @search_query = @search_query[0...-1]
            elsif msg.runes?
              @search_query += msg.to_s
            end
            [self, nil]
          end

          def toggle_pane
            if @pane == :categories
              @pane = :packs
              @cursor = 0
            else
              @pane = :categories
            end
          end

          def move_up
            if @pane == :categories
              @category_cursor = (@category_cursor - 1) % @categories.length
              @cursor = 0
            else
              @cursor = (@cursor - 1) % current_packs.length
            end
          end

          def move_down
            if @pane == :categories
              @category_cursor = (@category_cursor + 1) % @categories.length
              @cursor = 0
            else
              @cursor = (@cursor + 1) % current_packs.length
            end
          end

          def toggle_pack
            pack_name = current_packs[@cursor][:name]
            if @selected_packs.include?(pack_name)
              @selected_packs.delete(pack_name)
              @error = nil
            else
              result = try_select(pack_name)
              if result[:valid]
                @selected_packs.add(pack_name)
                result[:auto_added].each { |dep| @selected_packs.add(dep) }
                @error = if result[:auto_added].any?
                  "Auto-added dependencies: #{result[:auto_added].join(", ")}"
                end
              else
                @error = result[:errors].first
              end
            end
          end

          def toggle_search_result
            results = filtered_packs
            return if results.empty?

            pack_name = results.first[:name]
            if @selected_packs.include?(pack_name)
              @selected_packs.delete(pack_name)
              @error = nil
            else
              result = try_select(pack_name)
              if result[:valid]
                @selected_packs.add(pack_name)
                result[:auto_added].each { |dep| @selected_packs.add(dep) }
                @error = nil
              else
                @error = result[:errors].first
              end
            end
          end

          def try_select(pack_name)
            test_set = @selected_packs.to_a + [pack_name]
            @registry.validate_selection(test_set)
          end

          def filtered_packs
            return [] if @search_query.empty?
            q = @search_query.downcase
            @registry.as_catalog.select { |p|
              p[:name].include?(q) || p[:description].downcase.include?(q)
            }
          end

          def categories_view
            lines = []
            @categories.each_with_index do |cat, i|
              count = cat[:packs].count { |p| @selected_packs.include?(p[:name]) }
              label = "#{cat[:name]} (#{count}/#{cat[:packs].length})"
              lines << if i == @category_cursor
                Styles.selected.render("  > #{label}")
              else
                "    #{label}"
              end
            end
            lines
          end

          def packs_view
            lines = []
            lines << Styles.category_header.render("  #{current_category[:name]}")
            lines << ""
            current_packs.each_with_index do |pack, i|
              check = @selected_packs.include?(pack[:name]) ? "x" : " "
              label = "[#{check}] #{pack[:name]} — #{pack[:description]}"
              lines << if i == @cursor
                Styles.selected.render("  #{label}")
              else
                "  #{label}"
              end
            end
            lines
          end

          def search_results_view
            results = filtered_packs
            if results.empty?
              [Styles.dimmed.render("  No matching packs")]
            else
              results.first(10).map do |pack|
                check = @selected_packs.include?(pack[:name]) ? "x" : " "
                "  [#{check}] #{pack[:name]} — #{pack[:description]}"
              end
            end
          end

          def status_line
            Styles.status_bar.render(
              "  #{@selected_packs.length} packs selected"
            )
          end

          def help_line
            if @pane == :categories
              Styles.help.render("  Tab to browse packs • / to search • Enter to continue • Space to toggle")
            else
              Styles.help.render("  Tab for categories • Space to toggle • / to search • Enter to continue")
            end
          end
        end
      end
    end
  end
end
