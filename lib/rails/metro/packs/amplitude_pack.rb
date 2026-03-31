module Rails
  module Metro
    module Packs
      class AmplitudePack < FeaturePack
        pack_name "amplitude"
        description "Amplitude for product analytics, funnels, and retention"
        category "analytics"

        def gems
          [
            {name: "amplitude-api"}
          ]
        end

        def template_lines
          [
            'create_file "config/initializers/amplitude.rb", <<~RUBY',
            "  AmplitudeAPI.config.api_key = Rails.application.credentials.dig(:amplitude, :api_key) || ENV[\"AMPLITUDE_API_KEY\"]",
            "RUBY",
            "",
            'create_file "app/views/layouts/_amplitude.html.erb", <<~ERB',
            "  <script type=\"text/javascript\">",
            '    !function(){"use strict";!function(e,t){var r=e.amplitude||{_q:[],_iq:{}};if(r.invoked)e.console&&console.error&&console.error("Amplitude snippet has been loaded.");else{var n=function(e,t){e.prototype[t]=function(){return this._q.push({name:t,args:Array.prototype.slice.call(arguments,0)}),this}},s=function(e,t,r){return function(n){e._q.push({name:t,args:Array.prototype.slice.call(arguments,0),resolve:n})}},o=function(e,t,r){e._q.push({name:t,args:Array.prototype.slice.call(arguments,0)})},i=function(e,t,r){e[t]=function(){if(r)return{promise:new Promise(s(e,t,r))};o(e,t,r)}},a=function(e){for(var t=0;t<g.length;t++)i(e,g[t],!1);for(var r=0;r<m.length;r++)i(e,m[r],!0)};r.invoked=!0;var c=t.createElement("script");c.type="text/javascript",c.integrity="sha384-PPfHw98myKtJkA9OdPBMQ6n8yvUaYk0EyUQccFSIQGmB05K6aAMZwvv8d/EmYKhv",c.crossOrigin="anonymous",c.async=!0,c.src="https://cdn.amplitude.com/libs/analytics-browser-2.11.1-min.js.gz",c.onload=function(){e.amplitude.runQueuedFunctions||console.log("[Amplitude] Error: could not load SDK")};var u=t.getElementsByTagName("script")[0];u.parentNode.insertBefore(c,u);for(var l=function(){return this._q=[],this},p=["add","append","clearAll","prepend","set","setOnce","unset","preInsert","postInsert","remove","getUserProperties"],d=0;d<p.length;d++)n(l,p[d]);r.Identify=l;for(var f=function(){return this._q=[],this},v=["getEventProperties","setProductId","setQuantity","setPrice","setRevenue","setRevenueType","setEventProperties"],y=0;y<v.length;y++)n(f,v[y]);r.Revenue=f;var g=["getDeviceId","setDeviceId","getSessionId","setSessionId","getUserId","setUserId","setOptOut","setTransport","reset","extendSession"],m=["init","add","remove","track","logEvent","identify","groupIdentify","setGroup","revenue","flush"];a(r),r.createInstance=function(e){return r._iq[e]={_q:[]},a(r._iq[e]),r._iq[e]},e.amplitude=r}}(window,document)}();',
            '    amplitude.init("<%%= Rails.application.credentials.dig(:amplitude, :api_key) || ENV["AMPLITUDE_API_KEY"] %>");',
            "  </script>",
            "ERB",
            "",
            'inject_into_file "app/views/layouts/application.html.erb", after: "<head>\\n" do',
            '  "    <%= render \\"layouts/amplitude\\" %>\\n"',
            "end"
          ]
        end

        def post_install_notes
          [
            "Amplitude: Add your API key with `bin/rails credentials:edit`:",
            "  amplitude:",
            "    api_key: your_api_key",
            "Amplitude: Use `AmplitudeAPI.track(event)` server-side for backend events"
          ]
        end
      end
    end
  end
end
