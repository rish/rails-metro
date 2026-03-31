module Rails
  module Metro
    module Packs
      class EventSourcingPack < FeaturePack
        pack_name "event_sourcing"
        description "Rails Event Store for event sourcing and CQRS"
        category "data"

        def gems
          [
            {name: "rails_event_store"}
          ]
        end

        def template_lines
          [
            'rails_command "generate rails_event_store_active_record:install"'
          ]
        end

        def post_install_notes
          [
            "Event Store: Run `bin/rails db:migrate` to create events table",
            "Event Store: Publish events with `Rails.configuration.event_store.publish(event)`",
            "Event Store: Browse events at /res if you mount the browser engine"
          ]
        end
      end
    end
  end
end
