require "yaml"

module Rails
  module Metro
    class Config
      attr_accessor :app_name, :database, :selected_packs, :rails_args

      def initialize(app_name: nil, database: "sqlite3", selected_packs: [], rails_args: "")
        @app_name = app_name
        @database = database
        @selected_packs = selected_packs
        @rails_args = rails_args
      end

      def to_yaml
        {
          "app_name" => app_name,
          "database" => database,
          "selected_packs" => selected_packs,
          "rails_args" => rails_args
        }.to_yaml
      end

      def self.from_yaml(yaml_string)
        data = YAML.safe_load(yaml_string)
        new(
          app_name: data["app_name"],
          database: data.fetch("database", "sqlite3"),
          selected_packs: data.fetch("selected_packs", []),
          rails_args: data.fetch("rails_args", "")
        )
      end

      def summary
        packs_label = selected_packs.empty? ? "none" : selected_packs.join(", ")
        "#{app_name} (#{database}) packs: #{packs_label}"
      end
    end
  end
end
