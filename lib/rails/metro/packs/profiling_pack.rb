module Rails
  module Metro
    module Packs
      class ProfilingPack < FeaturePack
        pack_name "profiling"
        description "Stackprof + memory_profiler for CPU and memory profiling"
        category "ops"

        def gems
          [
            {name: "stackprof", group: :development},
            {name: "memory_profiler", group: :development}
          ]
        end

        def template_lines
          []
        end

        def post_install_notes
          [
            "Profiling: CPU profile with `StackProf.run(mode: :cpu) { code }` and `StackProf::Report`",
            "Profiling: Memory profile with `MemoryProfiler.report { code }.pretty_print`",
            "Profiling: Both available in development only"
          ]
        end
      end
    end
  end
end
