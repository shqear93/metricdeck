# Changelog

## [0.1.0] - 2026-05-27

- Initial release as **metricdeck**
- Extracted metric card framework from Athar EMS people service
- MetricCard value object with trend/comparison support
- BaseCalculator module with validate + perform interface
- CardHelpers with percentage_change, determine_trend, create_metric_card
- DateHelpers with parse_date, calculate_previous_period, generate_comparison_text
- MetricCardService with auto-discovery of calculators by namespace
- Rails generator for new calculators
