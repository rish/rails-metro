module Rails
  module Metro
    module Packs
      class S3StoragePack < FeaturePack
        pack_name "s3_storage"
        description "AWS S3 for Active Storage file uploads"
        category "core"
        conflicts_with "r2_storage", "gcs_storage", "azure_storage"

        def gems
          [
            {name: "aws-sdk-s3"}
          ]
        end

        def template_lines
          [
            'inject_into_file "config/storage.yml", <<~YML',
            "",
            "  amazon:",
            "    service: S3",
            "    access_key_id: <%= Rails.application.credentials.dig(:aws, :access_key_id) %>",
            "    secret_access_key: <%= Rails.application.credentials.dig(:aws, :secret_access_key) %>",
            '    region: <%= Rails.application.credentials.dig(:aws, :region) || "us-east-1" %>',
            "    bucket: <%= Rails.application.credentials.dig(:aws, :bucket) %>",
            "YML",
            "",
            'environment "config.active_storage.service = :amazon", env: "production"'
          ]
        end

        def post_install_notes
          [
            "S3: Add your AWS credentials with `bin/rails credentials:edit`:",
            "  aws:",
            "    access_key_id: AKIA...",
            "    secret_access_key: your_secret",
            "    region: us-east-1",
            "    bucket: your-bucket-name"
          ]
        end
      end
    end
  end
end
