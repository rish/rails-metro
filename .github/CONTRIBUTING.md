# Contributing to rails-metro

Thanks for your interest in contributing! rails-metro is a community-driven pack of Rails scaffolding tools and we welcome additions.

## Prerequisites

- Ruby >= 3.2
- Bundler

## Setup

```bash
git clone https://github.com/rish/rails-metro
cd rails-metro
bundle install
```

## Running Tests

```bash
bundle exec rake test          # Unit + golden file tests (fast, run these always)
bundle exec rake test:tui      # TUI step tests (requires bubbletea: gem install bubbletea)
bundle exec rake test:integration  # End-to-end: actually runs rails new (slow, ~60s)
bundle exec rake test:all      # Everything
bundle exec rake standard      # Lint (Standard Ruby)
bundle exec rake standard:fix  # Auto-fix lint issues
```

The default `rake` runs `test` + `standard`. Always make sure these pass before opening a PR.

## Adding a New Pack

Each pack is a single file in `lib/rails/metro/packs/`. Copy an existing one as a starting point:

```bash
cp lib/rails/metro/packs/slack_notifier_pack.rb lib/rails/metro/packs/my_pack.rb
```

A pack must define:

```ruby
module Rails
  module Metro
    module Packs
      class MyPack < FeaturePack
        pack_name "my_pack"           # snake_case, unique across all packs
        description "One-line description of what this pack adds"
        category "ops"                # admin, analytics, api, core, data, notifications,
                                      # ops, payments, seo, testing, or ui

        # Optional
        depends_on "other_pack"       # auto-resolved when my_pack is selected
        conflicts_with "rival_pack"   # mutually exclusive — see symmetry rule below

        def gems
          [
            {name: "my-gem"},                          # no version = any
            {name: "my-gem", version: "~> 2.0"},       # with constraint
            {name: "my-gem", group: :development}      # with Bundler group
          ]
        end

        def template_lines
          # Rails Application Template DSL strings, one per line
          [
            'generate "my_gem:install"',
            'create_file "config/initializers/my_gem.rb", <<~RUBY',
            "  MyGem.configure { |c| c.key = ENV[\"MY_GEM_KEY\"] }",
            "RUBY"
          ]
        end

        def post_install_notes
          [
            "MyGem: Set MY_GEM_KEY in your environment",
            "MyGem: See https://my-gem.com/docs for configuration"
          ]
        end
      end
    end
  end
end
```

### Conflict symmetry rule

If your pack declares `conflicts_with "other_pack"`, you **must** also add your pack to `other_pack`'s `conflicts_with`. The test suite enforces this:

```ruby
# both directions required:
# my_pack.rb
conflicts_with "rival_pack"

# rival_pack.rb
conflicts_with "my_pack"
```

### Regenerate golden files

If your pack affects any of the three golden test profiles (minimal, saas_starter, api_only), regenerate the expected output:

```bash
bundle exec ruby -e '
require "rails/metro"
Dir.glob("test/golden/inputs/*.yml").sort.each do |f|
  name = File.basename(f, ".yml")
  config = Rails::Metro::Config.from_yaml(File.read(f))
  registry = Rails::Metro::FeatureRegistry.default
  packs = config.selected_packs.empty? ? [] : registry.resolve(config.selected_packs)
  File.write("test/golden/expected/#{name}_template.rb",
    Rails::Metro::TemplateCompiler.new(config: config, packs: packs).compile)
end
'
```

## PR Guidelines

- One pack per PR is easiest to review, but related packs in a group are fine
- Keep `template_lines` minimal — generate config files, run generators, add routes
- Don't add `post_install_notes` that repeat what the gem's own README says clearly
- Integration tests run `rails new` for real — if your pack requires a service (Redis, Postgres), note that in the PR description

## Questions

Open a [Discussion](https://github.com/rish/rails-metro/discussions) for questions, ideas, or pack proposals before starting a large PR.
