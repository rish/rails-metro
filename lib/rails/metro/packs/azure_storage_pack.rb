module Rails
  module Metro
    module Packs
      class AzureStoragePack < FeaturePack
        pack_name "azure_storage"
        description "Azure Blob Storage for Active Storage file uploads"
        category "core"

        conflicts_with "s3_storage", "r2_storage", "gcs_storage"

        def gems
          [
            {name: "azure-storage-blob"}
          ]
        end

        def template_lines
          [
            'inject_into_file "config/storage.yml", <<~YML',
            "",
            "  azure:",
            "    service: AzureStorage",
            "    storage_account_name: <%= Rails.application.credentials.dig(:azure, :storage_account_name) %>",
            "    storage_access_key: <%= Rails.application.credentials.dig(:azure, :storage_access_key) %>",
            "    container: <%= Rails.application.credentials.dig(:azure, :container) %>",
            "YML",
            "",
            'environment "config.active_storage.service = :azure", env: "production"'
          ]
        end

        def post_install_notes
          [
            "Azure: Add your credentials with `bin/rails credentials:edit`:",
            "  azure:",
            "    storage_account_name: your-account-name",
            "    storage_access_key: your-access-key",
            "    container: your-container-name",
            "Azure: Create a storage account at portal.azure.com and grab the access key from Access Keys"
          ]
        end
      end
    end
  end
end
