module Rails
  module Metro
    module Packs
      class CircuitBreakerPack < FeaturePack
        pack_name "circuit_breaker"
        description "Circuitbox for circuit breaking on external service calls"
        category "ops"

        def gems
          [
            {name: "circuitbox"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/circuitbox.rb", <<~RUBY',
            "  Circuitbox.configure do |config|",
            "    config.default_circuit_store = Circuitbox::MemoryStore.new",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Circuitbox: Wrap external calls with `Circuitbox.circuit(:my_service, exceptions: [Timeout::Error]) { call }`",
            "Circuitbox: Circuit opens after repeated failures, preventing cascade failures"
          ]
        end
      end
    end
  end
end
