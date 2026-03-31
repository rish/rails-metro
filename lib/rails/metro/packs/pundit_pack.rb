module Rails
  module Metro
    module Packs
      class PunditPack < FeaturePack
        pack_name "pundit"
        description "Pundit for simple, policy-based authorization"
        category "core"
        conflicts_with "authorization"

        def gems
          [
            {name: "pundit"}
          ]
        end

        def template_lines
          [
            'inject_into_file "app/controllers/application_controller.rb", after: "class ApplicationController < ActionController::Base\\n" do',
            '  "  include Pundit::Authorization\\n"',
            "end",
            "",
            'create_file "app/policies/application_policy.rb", <<~RUBY',
            "  class ApplicationPolicy",
            "    attr_reader :user, :record",
            "",
            "    def initialize(user, record)",
            "      @user = user",
            "      @record = record",
            "    end",
            "",
            "    def index? = false",
            "    def show? = false",
            "    def create? = false",
            "    def update? = false",
            "    def destroy? = false",
            "  end",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "Pundit: Generate policies with `bin/rails g pundit:policy User`",
            "Pundit: Use `authorize @user` in controllers"
          ]
        end
      end
    end
  end
end
