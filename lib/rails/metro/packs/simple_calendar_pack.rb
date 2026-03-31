module Rails
  module Metro
    module Packs
      class SimpleCalendarPack < FeaturePack
        pack_name "simple_calendar"
        description "Simple Calendar for month/week/day calendar views"
        category "ui"

        def gems
          [
            {name: "simple_calendar", version: "~> 3.0"}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "Simple Calendar: Use `<%= month_calendar events: @events do |date, events| %>` in views",
            "Simple Calendar: Models need a `start_time` attribute (or configure with `attribute: :my_date`)",
            "Simple Calendar: Supports month_calendar, week_calendar, and custom ranges"
          ]
        end
      end
    end
  end
end
