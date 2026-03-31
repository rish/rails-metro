# Changelog

## [0.2.0] - 2026-03-31

### Added
- **`spark` pack** — Hotwire Spark hot reloading for HTML, CSS, and Ruby changes without full page reload (conflicts with `hotwire_livereload`)
- **`anycable` pack** — AnyCable high-performance WebSocket server replacing ActionCable (conflicts with `websockets`)

## [0.1.0] - 2026-03-31

### Added

- **130 feature packs** across 11 categories: admin, analytics, api, core, data, notifications, ops, payments, seo, testing, ui
- **`metro new`** CLI command — create a Rails app with selected packs (`--packs`, `--database`, `--rails_args`)
- **`metro tui`** — interactive 4-step wizard: app name → database → pack selection → review (requires `gem install bubbletea`)
- **`metro template`** — generate a template `.rb` file without running `rails new`
- **`metro from_config`** — generate from a saved `metro.yml` config file
- **`metro packs`** — list all available packs by category
- **FeatureRegistry** with topological dependency resolution, conflict detection, and circular dependency detection
- **TemplateCompiler** producing deterministic Rails Application Templates
- **Config** with YAML round-trip serialization (`metro.yml`)
- **Web API**: `FeatureRegistry#as_catalog` and `#validate_selection` for consumption by web UIs
- **67 tests**: unit, TUI step, golden file, and integration (actually runs `rails new` end-to-end)
