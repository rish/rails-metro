module Rails
  module Metro
    class FeaturePack
      class << self
        def pack_name(name = nil)
          if name
            @pack_name = name.to_s
          else
            @pack_name
          end
        end

        def description(desc = nil)
          if desc
            @description = desc
          else
            @description || ""
          end
        end

        def category(cat = nil)
          if cat
            @category = cat.to_s
          else
            @category || "general"
          end
        end

        def depends_on(*pack_names)
          if pack_names.any?
            @dependencies = pack_names.map(&:to_s)
          else
            @dependencies || []
          end
        end

        def conflicts_with(*pack_names)
          if pack_names.any?
            @conflicts = pack_names.map(&:to_s)
          else
            @conflicts || []
          end
        end
      end

      def gems
        []
      end

      def template_lines
        []
      end

      def post_install_notes
        []
      end
    end
  end
end
