module Rails
  module Metro
    module Packs
      class StorageValidationsPack < FeaturePack
        pack_name "storage_validations"
        description "Active Storage Validations for file type, size, and dimension checks"
        category "data"

        def gems
          [
            {name: "active_storage_validations"}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "Storage Validations: Use `validates :avatar, attached: true, content_type: :image` in models",
            "Storage Validations: Supports size, dimension, aspect ratio, and content type validations"
          ]
        end
      end
    end
  end
end
