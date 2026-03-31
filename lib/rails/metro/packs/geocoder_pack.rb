module Rails
  module Metro
    module Packs
      class GeocoderPack < FeaturePack
        pack_name "geocoder"
        description "Geocoder for address lookup, geocoding, and distance queries"
        category "data"

        def gems
          [
            {name: "geocoder"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/geocoder.rb", <<~RUBY',
            "  Geocoder.configure(",
            "    timeout: 5,",
            "    lookup: :nominatim,",
            "    units: :mi,",
            "    cache: Rails.cache",
            "  )",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Geocoder: Add `geocoded_by :address` to models with latitude/longitude columns",
            "Geocoder: Use `Model.near(\"New York\", 50)` for proximity search",
            "Geocoder: Default uses free Nominatim API -- switch to Google/Mapbox for production"
          ]
        end
      end
    end
  end
end
