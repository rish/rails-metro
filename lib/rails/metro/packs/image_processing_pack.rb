module Rails
  module Metro
    module Packs
      class ImageProcessingPack < FeaturePack
        pack_name "image_processing"
        description "Image processing for Active Storage variants using libvips (Rails 7+ recommended)"
        category "core"

        def gems
          [
            {name: "image_processing"},
            {name: "ruby-vips"}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "ImageProcessing: Install libvips on your system:",
            "  macOS:  brew install vips",
            "  Ubuntu: apt install libvips-tools",
            "  Heroku: add the heroku/heroku-buildpack-apt buildpack and apt-packages: libvips",
            "ImageProcessing: Use variants in views: <%= image_tag user.avatar.variant(resize_to_limit: [300, 300]) %>"
          ]
        end
      end
    end
  end
end
