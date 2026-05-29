# Changelog

## [0.1.2](https://github.com/shqear93/metricdeck/compare/metricdeck/v0.1.1...metricdeck/v0.1.2) (2026-05-29)


### Bug Fixes

* bound rails dependency to avoid open-ended warning ([ff74091](https://github.com/shqear93/metricdeck/commit/ff740911cf843e1c3024db98face4c631101547d))

## [0.1.1](https://github.com/shqear93/metricdeck/compare/metricdeck-v0.1.0...metricdeck/v0.1.1) (2026-05-29)


### Bug Fixes

* include release-please manifest in gem files ([6aff160](https://github.com/shqear93/metricdeck/commit/6aff1609e0fce806f1af6dfd392b521dd0a4dac5))

## [0.1.0] - 2026-05-27

- Initial release as **metricdeck**
- Extracted metric card framework from Athar EMS people service
- MetricCard value object with trend/comparison support
- BaseCalculator module with validate + perform interface
- CardHelpers with percentage_change, determine_trend, create_metric_card
- DateHelpers with parse_date, calculate_previous_period, generate_comparison_text
- MetricCardService with auto-discovery of calculators by namespace
- Rails generator for new calculators
