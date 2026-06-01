# metricdeck

[![CI](https://github.com/shqear93/metricdeck/actions/workflows/ci.yml/badge.svg)](https://github.com/shqear93/metricdeck/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/metricdeck.svg)](https://rubygems.org/gems/metricdeck)

A pluggable metric card framework for Ruby on Rails applications.

## Installation

Add to your Gemfile:

```ruby
gem 'metricdeck'
```

## Usage

### 1. Create a calculator

```ruby
# app/metrics/calculators/users_calculator.rb
module Metrics
  module Calculators
    class UsersCalculator
      include Metricdeck::Calculators::BaseCalculator
      include Metricdeck::Helpers::CardHelpers

      def validate_context(context)
        # optional validation
      end

      def perform_calculation(context)
        current = User.active.count
        previous = User.active.where('created_at <= ?', 1.month.ago).count

        create_metric_card(
          card_id,
          value: current,
          current: current,
          previous: previous
        )
      end
    end
  end
end
```

### 2. Fetch metric cards

```ruby
service = Metricdeck::MetricCardService.new(namespace: Metrics::Calculators)
cards = service.get_cards({ employee_id: 42 })
```

### 3. Generate a calculator

```bash
rails g metricdeck:calculator users
```

## I18n

Add translations under:

```yaml
en:
  metricdeck:
    cards:
      users:
        title: "Active Users"
        unit: "users"
    comparisons:
      previous_period: "vs previous period"
      last_month: "vs last month"
      last_year: "vs last year"
```

## GitHub Models Prompts

metricdeck includes reusable AI prompts in `.github/prompts/` for use with [GitHub Models](https://github.com/marketplace/models).

| Prompt | Purpose |
|--------|---------|
| `analyze-metric-card` | Deep-dive analysis of a single metric card |
| `compare-metric-cards` | Cross-metric correlation and trade-off analysis |
| `dashboard-summary` | Executive summary of a full dashboard |
| `generate-calculator-ideas` | AI-assisted brainstorming for new calculators |
| `metric-health-check` | Audit metrics for data quality issues |

### Usage

1. Go to [GitHub Models](https://github.com/marketplace/models)
2. Load a `.prompt.yml` file from this repo
3. Paste your metric JSON in the `{{variable}}` placeholders
4. Run the prompt against your chosen model

### Customizing

Copy any `.prompt.yml` and adjust the `model` or `modelParameters` to suit your needs. See [GitHub Docs](https://docs.github.com/en/github-models/use-github-models/storing-prompts-in-github-repositories) for the full prompt file specification.

## Migrating from Athar EMS People Service

If you're migrating from the internal `Statistics` module in the Athar EMS people service:

1. Replace `Statistics::Calculators::BaseCalculator` with `Metricdeck::Calculators::BaseCalculator`
2. Replace `Statistics::Helpers::CardHelpers` with `Metricdeck::Helpers::CardHelpers`
3. Replace `Statistics::Helpers::DateHelpers` with `Metricdeck::Helpers::DateHelpers`
4. Replace `Statistics::MetricCardService` with `Metricdeck::MetricCardService`
5. Replace `Statistics::MetricCard` with `Metricdeck::MetricCard`
6. Update i18n keys from `statistics.*` to `metricdeck.*`
7. Pass your calculator namespace explicitly:
   ```ruby
   service = Metricdeck::MetricCardService.new(namespace: Statistics::Calculators)
   ```
