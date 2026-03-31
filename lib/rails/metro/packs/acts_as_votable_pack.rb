module Rails
  module Metro
    module Packs
      class ActsAsVotablePack < FeaturePack
        pack_name "acts_as_votable"
        description "Acts As Votable for likes, upvotes, and reactions"
        category "data"

        def gems
          [
            {name: "acts_as_votable"}
          ]
        end

        def template_lines
          [
            'rails_command "generate acts_as_votable:migration"'
          ]
        end

        def post_install_notes
          [
            "Votable: Run `bin/rails db:migrate` to create votes table",
            "Votable: Add `acts_as_votable` to models that can be voted on",
            "Votable: Add `acts_as_voter` to User model",
            "Votable: Use `user.likes @post` and `@post.liked_by user`"
          ]
        end
      end
    end
  end
end
