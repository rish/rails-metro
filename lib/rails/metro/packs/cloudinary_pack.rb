module Rails
  module Metro
    module Packs
      class CloudinaryPack < FeaturePack
        pack_name "cloudinary"
        description "Cloudinary for cloud image and video management"
        category "ui"

        def gems
          [
            {name: "cloudinary"},
            {name: "activestorage-cloudinary-service"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/cloudinary.rb", <<~RUBY',
            "  Cloudinary.config do |config|",
            '    config.cloud_name = Rails.application.credentials.dig(:cloudinary, :cloud_name) || ENV["CLOUDINARY_CLOUD_NAME"]',
            '    config.api_key = Rails.application.credentials.dig(:cloudinary, :api_key) || ENV["CLOUDINARY_API_KEY"]',
            '    config.api_secret = Rails.application.credentials.dig(:cloudinary, :api_secret) || ENV["CLOUDINARY_API_SECRET"]',
            "    config.secure = true",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Cloudinary: Add your credentials with `bin/rails credentials:edit`:",
            "  cloudinary:",
            "    cloud_name: your_cloud_name",
            "    api_key: your_api_key",
            "    api_secret: your_api_secret",
            "Cloudinary: Use as Active Storage service by setting `service: Cloudinary` in storage.yml"
          ]
        end
      end
    end
  end
end
