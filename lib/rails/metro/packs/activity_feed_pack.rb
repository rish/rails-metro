module Rails
  module Metro
    module Packs
      class ActivityFeedPack < FeaturePack
        pack_name "activity_feed"
        description "Public Activity for activity feeds and timelines"
        category "data"

        def gems
          [
            {name: "public_activity"}
          ]
        end

        def template_lines
          [
            'rails_command "generate public_activity:migration"'
          ]
        end

        def post_install_notes
          [
            "Activity Feed: Run `bin/rails db:migrate` to create activities table",
            "Activity Feed: Add `include PublicActivity::Model` and `tracked` to models",
            "Activity Feed: Query with `PublicActivity::Activity.order(created_at: :desc)`"
          ]
        end
      end
    end
  end
end
