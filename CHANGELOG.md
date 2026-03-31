# Changelog

## [0.3.0] - 2026-03-31

### Added
- **`image_processing` pack** — ActiveStorage image variants via libvips (`image_processing` + `ruby-vips`)
- **`gcs_storage` pack** — Google Cloud Storage backend for ActiveStorage
- **`azure_storage` pack** — Azure Blob Storage backend for ActiveStorage
- **`shrine` pack** — Shrine file attachment library, alternative to ActiveStorage (conflicts with `carrierwave`)
- **`carrierwave` pack** — CarrierWave file upload library (conflicts with `shrine`)
- **`sentry` pack** — renamed from `error_tracking` to match the actual gem installed

### Changed
- Removed unnecessary conflicts between error tracking packs (`sentry`, `honeybadger`, `rollbar`) — all can coexist
- Removed unnecessary conflicts between search packs (`search`, `elasticsearch`, `meilisearch`) — all can coexist
- Storage backend packs (`s3_storage`, `r2_storage`, `gcs_storage`, `azure_storage`) now correctly conflict with each other

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
