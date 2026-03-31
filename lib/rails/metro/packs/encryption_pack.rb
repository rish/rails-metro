module Rails
  module Metro
    module Packs
      class EncryptionPack < FeaturePack
        pack_name "encryption"
        description "Lockbox for application-level field encryption"
        category "data"

        def gems
          [
            {name: "lockbox"},
            {name: "blind_index"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/lockbox.rb", <<~RUBY',
            "  Lockbox.master_key = Rails.application.credentials.dig(:lockbox, :master_key) || ENV[\"LOCKBOX_MASTER_KEY\"]",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Lockbox: Generate a master key with `Lockbox.generate_key`",
            "Lockbox: Add to credentials with `bin/rails credentials:edit`:",
            "  lockbox:",
            "    master_key: your_generated_key",
            "Lockbox: Use `encrypts :email` in models to encrypt fields",
            "Lockbox: Use `blind_index :email` for searchable encrypted fields"
          ]
        end
      end
    end
  end
end
