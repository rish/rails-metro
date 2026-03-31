module Rails
  module Metro
    module Packs
      class GcsStoragePack < FeaturePack
        pack_name "gcs_storage"
        description "Google Cloud Storage for Active Storage file uploads"
        category "core"

        conflicts_with "s3_storage", "r2_storage", "azure_storage"

        def gems
          [
            {name: "google-cloud-storage"}
          ]
        end

        def template_lines
          [
            'inject_into_file "config/storage.yml", <<~YML',
            "",
            "  google:",
            "    service: GCS",
            "    project: <%= Rails.application.credentials.dig(:gcs, :project) %>",
            "    credentials: <%= Rails.application.credentials.dig(:gcs, :credentials) %>",
            "    bucket: <%= Rails.application.credentials.dig(:gcs, :bucket) %>",
            "YML",
            "",
            'environment "config.active_storage.service = :google", env: "production"'
          ]
        end

        def post_install_notes
          [
            "GCS: Add your credentials with `bin/rails credentials:edit`:",
            "  gcs:",
            "    project: your-gcp-project-id",
            "    bucket: your-bucket-name",
            "    credentials:",
            "      type: service_account",
            "      project_id: your-gcp-project-id",
            "      private_key_id: ...",
            "      private_key: ...",
            "GCS: Create a service account at console.cloud.google.com with Storage Object Admin role"
          ]
        end
      end
    end
  end
end
