module Rails
  module Metro
    module Packs
      class AuditTrailPack < FeaturePack
        pack_name "audit_trail"
        description "PaperTrail for model versioning and audit trail"
        category "data"

        def gems
          [
            {name: "paper_trail", version: "~> 16.0"}
          ]
        end

        def template_lines
          [
            'rails_command "generate paper_trail:install"'
          ]
        end

        def post_install_notes
          [
            "PaperTrail: Run `bin/rails db:migrate` to create versions table",
            "PaperTrail: Add `has_paper_trail` to models you want to track",
            "PaperTrail: Access history with `record.versions` and `record.paper_trail.previous_version`"
          ]
        end
      end
    end
  end
end
