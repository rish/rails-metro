module Rails
  module Metro
    module Packs
      class CarrierWavePack < FeaturePack
        pack_name "carrierwave"
        description "CarrierWave file upload library"
        category "core"

        conflicts_with "shrine"

        def gems
          [
            {name: "carrierwave"}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "CarrierWave: Generate your first uploader: rails generate uploader Avatar",
            "CarrierWave: Mount in a model: mount_uploader :avatar, AvatarUploader",
            "CarrierWave: Add migration: add_column :users, :avatar, :string",
            "CarrierWave: See https://github.com/carrierwaveuploader/carrierwave for docs"
          ]
        end
      end
    end
  end
end
