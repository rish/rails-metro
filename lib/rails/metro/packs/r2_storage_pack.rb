module Rails
  module Metro
    module Packs
      class R2StoragePack < FeaturePack
        pack_name "r2_storage"
        description "Cloudflare R2 for S3-compatible Active Storage (no egress fees)"
        category "core"
        conflicts_with "s3_storage"

        def gems
          [
            {name: "aws-sdk-s3"}
          ]
        end

        def template_lines
          [
            'inject_into_file "config/storage.yml", <<~YML',
            "",
            "  r2:",
            "    service: S3",
            "    endpoint: <%= Rails.application.credentials.dig(:r2, :endpoint) %>",
            '    region: <%= Rails.application.credentials.dig(:r2, :region) || "auto" %>',
            "    bucket: <%= Rails.application.credentials.dig(:r2, :bucket) %>",
            "    access_key_id: <%= Rails.application.credentials.dig(:r2, :access_key_id) %>",
            "    secret_access_key: <%= Rails.application.credentials.dig(:r2, :secret_access_key) %>",
            "YML",
            "",
            'environment "config.active_storage.service = :r2", env: "production"'
          ]
        end

        def post_install_notes
          [
            "R2: Add your Cloudflare credentials with `bin/rails credentials:edit`:",
            "  r2:",
            "    endpoint: https://ACCOUNT_ID.r2.cloudflarestorage.com",
            "    region: auto",
            "    bucket: your-bucket-name",
            "    access_key_id: your_access_key",
            "    secret_access_key: your_secret_key",
            "R2: Zero egress fees -- great for media-heavy apps"
          ]
        end
      end
    end
  end
end
