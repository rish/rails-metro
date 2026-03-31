module Rails
  module Metro
    class FeatureRegistry
      class DependencyError < StandardError; end
      class ConflictError < StandardError; end

      def initialize
        @packs = {}
      end

      def register(pack_class)
        name = pack_class.pack_name
        raise ArgumentError, "Pack must define a pack_name" unless name
        @packs[name] = pack_class
      end

      def all
        @packs.values
      end

      def names
        @packs.keys.sort
      end

      def find(name)
        @packs[name.to_s]
      end

      def categories
        all.group_by { |p| p.category }
      end

      def resolve(selected_names)
        selected = selected_names.map(&:to_s)
        validate_existence!(selected)
        validate_conflicts!(selected)
        expand_dependencies(selected)
      end

      def as_catalog
        all.sort_by(&:pack_name).map do |pack_class|
          {
            name: pack_class.pack_name,
            description: pack_class.description,
            category: pack_class.category,
            depends_on: pack_class.depends_on,
            conflicts_with: pack_class.conflicts_with
          }
        end
      end

      def validate_selection(selected_names)
        selected = selected_names.map(&:to_s)
        result = {valid: true, errors: [], auto_added: []}

        unknown = selected - @packs.keys
        if unknown.any?
          result[:valid] = false
          result[:errors] << "Unknown packs: #{unknown.join(", ")}"
          return result
        end

        selected.each do |name|
          pack = @packs[name]
          conflicting = pack.conflicts_with & selected
          if conflicting.any?
            result[:valid] = false
            result[:errors] << "Pack '#{name}' conflicts with: #{conflicting.join(", ")}"
          end
        end

        return result unless result[:valid]

        resolved = expand_dependencies(selected)
        resolved_names = resolved.map(&:pack_name)
        result[:auto_added] = resolved_names - selected
        result
      rescue DependencyError => e
        result[:valid] = false
        result[:errors] << e.message
        result
      end

      def self.default
        @default ||= build_default
      end

      def self.build_default
        registry = new
        load_builtin_packs
        builtin_pack_classes.each { |klass| registry.register(klass) }
        registry
      end

      def self.load_builtin_packs
        Dir.glob(File.join(__dir__, "packs", "**", "*_pack.rb")).sort.each { |f| require f }
      end

      def self.builtin_pack_classes
        ObjectSpace.each_object(Class).select { |c|
          c < FeaturePack && c.pack_name && c.name&.start_with?("Rails::Metro::Packs::")
        }
      end

      private

      def validate_existence!(names)
        unknown = names - @packs.keys
        if unknown.any?
          raise DependencyError, "Unknown packs: #{unknown.join(", ")}. Available: #{@packs.keys.sort.join(", ")}"
        end
      end

      def validate_conflicts!(names)
        names.each do |name|
          pack = @packs[name]
          conflicting = pack.conflicts_with & names
          if conflicting.any?
            raise ConflictError, "Pack '#{name}' conflicts with: #{conflicting.join(", ")}"
          end
        end
      end

      def expand_dependencies(names)
        resolved = []
        visited = Set.new
        names.each { |name| visit(name, resolved, visited, []) }
        resolved
      end

      def visit(name, resolved, visited, stack)
        return if visited.include?(name)
        if stack.include?(name)
          raise DependencyError, "Circular dependency: #{(stack + [name]).join(" -> ")}"
        end

        stack.push(name)
        pack = @packs[name]
        pack.depends_on.each { |dep| visit(dep, resolved, visited, stack) }
        stack.pop

        visited.add(name)
        resolved << @packs[name]
      end
    end
  end
end
