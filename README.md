# rails-metro

The ultimate Rails app scaffolding tool. Pick the features you need -- authentication, analytics, payments, background jobs, and 120+ more -- and get a production-ready Rails app in one command.

rails-metro compiles your selections into a [Rails Application Template](https://guides.rubyonrails.org/rails_application_templates.html), runs `rails new`, and hands you a standard Rails app with **no runtime dependency** on this gem.

## Installation

```bash
gem install rails-metro

# For the interactive TUI (optional)
gem install bubbletea
```

## Quick Start

```bash
# Interactive mode (recommended)
metro tui

# CLI mode
metro new myapp --packs=authentication,posthog,background_jobs,deployment --database=postgresql

# Just generate the template file
metro template myapp --packs=posthog,blazer --output=template.rb

# Generate from a saved config
metro from_config metro.yml
```

## Commands

| Command | Description |
|---------|-------------|
| `metro tui` | Interactive TUI for configuring your app |
| `metro new APP_NAME` | Create a new Rails app with selected packs |
| `metro template APP_NAME` | Generate a template file without running rails new |
| `metro from_config PATH` | Generate from a saved `metro.yml` config |
| `metro packs` | List all available feature packs |
| `metro version` | Show version |

### CLI Options

```bash
metro new myapp \
  --database=postgresql \        # sqlite3, postgresql, mysql2
  --packs=auth,posthog,deploy \  # comma-separated pack names
  --rails_args="--api"           # pass-through to rails new
```

## Interactive TUI

The TUI walks you through four steps:

1. **App name** -- validates format
2. **Database** -- sqlite3, postgresql, or mysql2
3. **Pack selection** -- browse by category, search with `/`, toggle with Space
4. **Review** -- generate the app, export config, or export template

Dependencies are auto-resolved and conflicts are blocked inline.

Requires the `bubbletea` gem (`gem install bubbletea`).

## Feature Packs (130)

### Admin
- **activeadmin** -- ActiveAdmin -- classic, battle-tested admin framework
- **administrate** -- Administrate -- Thoughtbot's lightweight admin framework
- **avo** -- Avo -- modern, customizable admin panel framework
- **madmin** -- Madmin -- a modern admin framework by Chris Oliver (GoRails)

### Analytics
- **ahoy** -- Ahoy for visit and event tracking (first-party analytics)
- **amplitude** -- Amplitude for product analytics, funnels, and retention
- **blazer** -- SQL analytics dashboards with Blazer
- **clicky** -- Clicky for real-time web analytics
- **fathom** -- Fathom -- simple, privacy-focused website analytics
- **google_analytics** -- Google Analytics 4 (GA4) for web analytics
- **google_tag_manager** -- Google Tag Manager for managing analytics and marketing tags
- **heap** -- Heap for auto-captured product analytics
- **matomo** -- Matomo -- self-hosted open-source web analytics
- **mixpanel** -- Mixpanel for event-based product analytics
- **plausible** -- Plausible -- privacy-focused analytics (no cookies, GDPR compliant)
- **posthog** -- PostHog product analytics (server-side + JS snippet)
- **statcounter** -- StatCounter for visitor stats and web analytics

### API
- **api_cors** -- Rack CORS for cross-origin API requests
- **api_docs** -- Rswag for Swagger/OpenAPI documentation from tests
- **api_guard** -- API Guard for JWT authentication
- **api_serialization** -- Alba for fast, flexible JSON serialization
- **doorkeeper** -- Doorkeeper for OAuth2 provider
- **graphql** -- GraphQL API with graphql-ruby
- **webhooks** -- Incoming and outgoing webhook handling

### Core
- **authentication** -- authentication-zero (2FA, recovery codes, you own the code)
- **authorization** -- Action Policy for authorization
- **background_jobs** -- Solid Queue + Mission Control Jobs (no Redis)
- **caching** -- Solid Cache (database-backed caching)
- **devise** -- Devise for full-featured authentication
- **faraday** -- Faraday for composable HTTP requests
- **good_job** -- GoodJob for Postgres-backed background jobs
- **invisible_captcha** -- Invisible Captcha for honeypot spam prevention
- **mobility** -- Mobility for translatable model attributes
- **multitenancy** -- acts_as_tenant for row-based multi-tenancy
- **omniauth** -- OmniAuth for social/OAuth login
- **passwordless** -- Passwordless for magic-link authentication
- **pundit** -- Pundit for simple, policy-based authorization
- **r2_storage** -- Cloudflare R2 for Active Storage (no egress fees)
- **rails_i18n** -- Rails I18n locale data for 100+ languages
- **recaptcha** -- reCAPTCHA v3 for bot protection
- **rolify** -- Rolify for role management
- **s3_storage** -- AWS S3 for Active Storage
- **scheduling** -- Recurring tasks with Solid Queue _(requires: background_jobs)_
- **sidekiq** -- Sidekiq for Redis-backed background jobs
- **websockets** -- Solid Cable (database-backed ActionCable)

### Data
- **aasm** -- AASM for state machines
- **ab_testing** -- Split for A/B testing
- **activity_feed** -- Public Activity for timelines
- **acts_as_list** -- Acts As List for sortable records
- **acts_as_votable** -- Acts As Votable for likes/upvotes
- **annotate** -- Annotate models with schema info
- **audit_trail** -- PaperTrail for model versioning
- **counter_culture** -- Counter Culture for counter caches
- **data_migrate** -- Data Migrate for data migrations
- **elasticsearch** -- Searchkick for Elasticsearch search
- **encryption** -- Lockbox for field encryption
- **event_sourcing** -- Rails Event Store for event sourcing/CQRS
- **geocoder** -- Geocoder for address lookup and distance
- **kredis** -- Kredis for structured Redis types
- **meilisearch** -- Meilisearch for fast full-text search
- **scenic** -- Scenic for versioned database views
- **search** -- pg_search for PostgreSQL full-text search
- **soft_deletes** -- Discard for soft deletes
- **storage_validations** -- Active Storage file validations
- **strong_migrations** -- Catch unsafe migrations before they run
- **tagging** -- Acts As Taggable On

### Notifications
- **aws_ses** -- Amazon SES for email delivery
- **mailgun** -- Mailgun for transactional email
- **notifications** -- Noticed for multi-channel notifications
- **postmark** -- Postmark for transactional email
- **resend** -- Resend for email delivery
- **sendgrid** -- SendGrid for email delivery
- **sent_dm** -- Sent.dm for multi-channel messaging
- **slack_notifier** -- Slack webhook notifications
- **twilio** -- Twilio for SMS, voice, and WhatsApp
- **web_push** -- Web Push for browser notifications

### Ops
- **after_party** -- AfterParty for one-time post-deploy tasks
- **app_linting** -- Standard Ruby + ERB Lint
- **circuit_breaker** -- Circuitbox for circuit breaking
- **datadog** -- Datadog APM for tracing and metrics
- **deployment** -- Kamal for zero-downtime deploys
- **dotenv** -- Dotenv for .env files in development
- **error_tracking** -- Sentry for error tracking
- **feature_flags** -- Flipper for feature flags
- **health_check** -- OkComputer for health check endpoints
- **honeybadger** -- Honeybadger for error tracking
- **hotwire_livereload** -- Hotwire LiveReload for dev
- **letter_opener** -- Letter Opener for email preview (dev)
- **letter_opener_web** -- Letter Opener Web UI _(requires: letter_opener)_
- **logging** -- Lograge for structured request logs
- **maintenance_mode** -- Turnout for maintenance pages
- **maintenance_tasks** -- Maintenance Tasks (Shopify)
- **newrelic** -- New Relic APM
- **performance** -- Rack Mini Profiler + Bullet
- **pghero** -- PgHero for Postgres performance dashboard
- **pretender** -- Pretender for user impersonation
- **profiling** -- Stackprof + memory_profiler
- **rack_timeout** -- Rack::Timeout for request protection
- **rate_limiting** -- Rack::Attack for throttling
- **rollbar** -- Rollbar for error tracking
- **security** -- Brakeman + bundler-audit

### Payments
- **lemon_squeezy** -- Lemon Squeezy (merchant of record)
- **mollie** -- Mollie for European payments
- **paddle** -- Paddle (merchant of record)
- **payments** -- Pay + Stripe for subscriptions
- **paypal** -- PayPal for payments and checkout
- **revenuecat** -- RevenueCat for subscription management
- **solidus** -- Solidus for full e-commerce

### SEO
- **seo** -- meta-tags + sitemap_generator

### Testing
- **shoulda_matchers** -- Shoulda Matchers for one-liner assertions
- **simplecov** -- SimpleCov for code coverage
- **test_mocking** -- VCR + WebMock for HTTP recording
- **testing** -- FactoryBot + Faker + Capybara

### UI
- **action_text** -- Action Text for rich text editing
- **breadcrumbs** -- Gretel for breadcrumb navigation
- **charting** -- Chartkick + Groupdate for charts
- **cloudinary** -- Cloudinary for image/video management
- **components** -- ViewComponent for component-based views
- **friendly_id** -- FriendlyId for URL slugs
- **icons** -- Lucide Rails for SVG icons
- **markdown** -- Redcarpet for Markdown rendering
- **pagination** -- Pagy for pagination
- **pdf** -- Grover for PDF generation
- **qr_code** -- RQRCode for QR code generation
- **ransack** -- Ransack for search/filter forms
- **simple_calendar** -- Simple Calendar for calendar views
- **simple_form** -- Simple Form for form building
- **spreadsheets** -- Caxlsx for Excel generation
- **stimulus_components** -- Pre-built Stimulus controllers
- **vite_rails** -- Vite Rails for frontend bundling with HMR

## Dependencies and Conflicts

Packs can declare dependencies and conflicts:

- **Dependencies** are auto-resolved. Selecting `scheduling` automatically adds `background_jobs`.
- **Conflicts** are mutually exclusive. You can't select both `authentication` and `devise`, or both `sidekiq` and `good_job`.

## How It Works

1. You select packs via the TUI, CLI flags, or a `metro.yml` config file
2. rails-metro resolves dependencies and validates conflicts
3. A Rails Application Template is compiled from your selections
4. `rails new` runs with that template
5. You get a standard Rails app -- no runtime dependency on rails-metro

## Config File

Export and reuse configurations:

```yaml
# metro.yml
app_name: myapp
database: postgresql
selected_packs:
  - authentication
  - posthog
  - background_jobs
  - deployment
rails_args: ""
```

```bash
metro from_config metro.yml
```

## Development

```bash
bundle install
bundle exec rake test          # Unit + golden file tests
bundle exec rake test:tui      # TUI step tests
bundle exec rake test:integration  # End-to-end (runs rails new)
bundle exec rake test:all      # Everything
bundle exec rake standard      # Lint
```

## License

MIT
