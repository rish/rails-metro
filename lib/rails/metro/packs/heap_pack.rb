module Rails
  module Metro
    module Packs
      class HeapPack < FeaturePack
        pack_name "heap"
        description "Heap for auto-captured product analytics"
        category "analytics"

        def gems
          []
        end

        def template_lines
          [
            'create_file "app/views/layouts/_heap.html.erb", <<~ERB',
            "  <script type=\"text/javascript\">",
            '    window.heap=window.heap||[],heap.load=function(e,t){window.heap.appid=e,window.heap.config=t=t||{};var r=document.createElement("script");r.type="text/javascript",r.async=!0,r.src="https://cdn.heapanalytics.com/js/heap-"+e+".js";var a=document.getElementsByTagName("script")[0];a.parentNode.insertBefore(r,a);for(var n=function(e){return function(){heap.push([e].concat(Array.prototype.slice.call(arguments,0)))}},p=["addEventProperties","addUserProperties","clearEventProperties","identify","resetIdentity","removeEventProperty","setEventProperties","track","unsetEventProperty"],o=0;o<p.length;o++)heap[p[o]]=n(p[o])};',
            '    heap.load("<%%= Rails.application.credentials.dig(:heap, :app_id) || ENV["HEAP_APP_ID"] %>");',
            "  </script>",
            "ERB",
            "",
            'inject_into_file "app/views/layouts/application.html.erb", after: "<head>\\n" do',
            '  "    <%= render \\"layouts/heap\\" %>\\n"',
            "end"
          ]
        end

        def post_install_notes
          [
            "Heap: Add your app ID with `bin/rails credentials:edit`:",
            "  heap:",
            "    app_id: \"1234567890\"",
            "Heap: Auto-captures all user interactions -- no manual event tracking needed"
          ]
        end
      end
    end
  end
end
