module Rails
  module Metro
    module Packs
      class ShrinePack < FeaturePack
        pack_name "shrine"
        description "Shrine file attachment library — flexible alternative to Active Storage"
        category "core"

        conflicts_with "carrierwave"

        def gems
          [
            {name: "shrine"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/shrine.rb", <<~RUBY',
            "  require \"shrine\"",
            "  require \"shrine/storage/file_system\"",
            "",
            "  if Rails.env.production?",
            "    require \"shrine/storage/s3\"",
            "",
            "    s3_options = {",
            "      bucket: Rails.application.credentials.dig(:aws, :bucket),",
            "      region: Rails.application.credentials.dig(:aws, :region) || \"us-east-1\",",
            "      access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),",
            "      secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)",
            "    }",
            "",
            "    Shrine.storages = {",
            "      cache: Shrine::Storage::S3.new(prefix: \"cache\", **s3_options),",
            "      store: Shrine::Storage::S3.new(**s3_options)",
            "    }",
            "  else",
            "    Shrine.storages = {",
            "      cache: Shrine::Storage::FileSystem.new(\"public\", prefix: \"uploads/cache\"),",
            "      store: Shrine::Storage::FileSystem.new(\"public\", prefix: \"uploads\")",
            "    }",
            "  end",
            "",
            "  Shrine.plugin :activerecord",
            "  Shrine.plugin :cached_attachment_data",
            "  Shrine.plugin :restore_cached_data",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Shrine: Create an uploader: app/uploaders/image_uploader.rb",
            "Shrine: Include in models: include ImageUploader::Attachment(:photo)",
            "Shrine: Add migration: add_column :users, :photo_data, :text",
            "Shrine: See https://shrinerb.com for full documentation"
          ]
        end
      end
    end
  end
end
