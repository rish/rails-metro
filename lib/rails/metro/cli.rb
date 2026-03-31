require "thor"

module Rails
  module Metro
    class CLI < Thor
      def self.exit_on_failure?
        true
      end

      desc "new APP_NAME", "Create a new Rails app with selected feature packs"
      option :database, type: :string, default: "sqlite3", desc: "Database adapter (sqlite3, postgresql, mysql2)"
      option :packs, type: :string, default: "", desc: "Comma-separated list of feature packs to enable"
      option :rails_args, type: :string, default: "", desc: "Additional arguments passed through to rails new"
      def new(app_name)
        selected_packs = options[:packs].split(",").map(&:strip).reject(&:empty?)

        config = Config.new(
          app_name: app_name,
          database: options[:database],
          selected_packs: selected_packs,
          rails_args: options[:rails_args]
        )

        registry = FeatureRegistry.default
        resolved_packs = registry.resolve(config.selected_packs)

        compiler = TemplateCompiler.new(config: config, packs: resolved_packs)
        template_path = compiler.compile_to_file

        say "rails-metro v#{VERSION}", :green
        say "Packs: #{resolved_packs.map(&:pack_name).join(", ")}", :cyan unless resolved_packs.empty?
        say "Template: #{template_path}", :cyan
        say ""

        rails_cmd = build_rails_command(app_name, config, template_path)
        say "Running: #{rails_cmd}", :yellow
        system(rails_cmd)

        notes = compiler.post_install_notes
        if notes.any?
          say ""
          say "Post-install notes:", :green
          notes.each { |note| say "  - #{note}" }
        end
      ensure
        File.unlink(template_path) if template_path && File.exist?(template_path)
      end

      desc "packs", "List available feature packs"
      def packs
        registry = FeatureRegistry.default
        registry.categories.sort.each do |category, pack_classes|
          say category, :green
          pack_classes.sort_by(&:pack_name).each do |pack|
            deps = pack.depends_on.any? ? " (requires: #{pack.depends_on.join(", ")})" : ""
            say "  #{pack.pack_name} - #{pack.description}#{deps}"
          end
          say ""
        end
      end

      desc "template APP_NAME", "Generate a Rails template file without running rails new"
      option :packs, type: :string, default: "", desc: "Comma-separated list of feature packs to enable"
      option :output, type: :string, default: nil, desc: "Output file path (default: stdout)"
      def template(app_name)
        selected_packs = options[:packs].split(",").map(&:strip).reject(&:empty?)

        config = Config.new(
          app_name: app_name,
          selected_packs: selected_packs
        )

        registry = FeatureRegistry.default
        resolved_packs = registry.resolve(config.selected_packs)
        compiler = TemplateCompiler.new(config: config, packs: resolved_packs)
        content = compiler.compile

        if options[:output]
          File.write(options[:output], content)
          say "Template written to #{options[:output]}", :green
        else
          puts content
        end
      end

      desc "tui", "Launch interactive TUI for configuring your Rails app"
      def tui
        require_relative "tui"
        config, action = Tui.run

        return unless action

        case action
        when "g"
          generate_from_config(config)
        when "e"
          path = "metro.yml"
          File.write(path, config.to_yaml)
          say "Config saved to #{path}", :green
        when "t"
          registry = FeatureRegistry.default
          resolved_packs = config.selected_packs.empty? ? [] : registry.resolve(config.selected_packs)
          compiler = TemplateCompiler.new(config: config, packs: resolved_packs)
          path = "template.rb"
          File.write(path, compiler.compile)
          say "Template saved to #{path}", :green
        end
      end

      desc "from_config PATH", "Generate a Rails app from a metro.yml config file"
      def from_config(path)
        unless File.exist?(path)
          say "File not found: #{path}", :red
          exit 1
        end

        config = Config.from_yaml(File.read(path))
        generate_from_config(config)
      end

      desc "version", "Show rails-metro version"
      def version
        say "rails-metro v#{VERSION}"
      end

      private

      def generate_from_config(config)
        registry = FeatureRegistry.default
        resolved_packs = config.selected_packs.empty? ? [] : registry.resolve(config.selected_packs)

        compiler = TemplateCompiler.new(config: config, packs: resolved_packs)
        template_path = compiler.compile_to_file

        say "rails-metro v#{VERSION}", :green
        say "Config: #{config.summary}", :cyan
        say ""

        rails_cmd = build_rails_command(config.app_name, config, template_path)
        say "Running: #{rails_cmd}", :yellow
        system(rails_cmd)

        notes = compiler.post_install_notes
        if notes.any?
          say ""
          say "Post-install notes:", :green
          notes.each { |note| say "  - #{note}" }
        end
      ensure
        File.unlink(template_path) if template_path && File.exist?(template_path)
      end

      def build_rails_command(app_name, config, template_path)
        parts = ["rails", "new", app_name]
        parts += ["--database=#{config.database}"] unless config.database == "sqlite3"
        parts += ["-m", template_path]
        parts += config.rails_args.split unless config.rails_args.empty?
        parts.join(" ")
      end
    end
  end
end
