# frozen_string_literal: true

module Metricdeck
  module Helpers
    module CardHelpers
      def calculate_percentage_change(current, previous)
        return 0 if previous.to_f.zero?

        ((current.to_f - previous.to_f) / previous.to_f * 100).round(1)
      end

      def determine_trend(current, previous)
        return 'neutral' if previous.to_f.zero? || current == previous

        current > previous ? 'up' : 'down'
      end

      def create_metric_card(id, value:, current:, previous:, title_key: nil, unit_key: nil,
                             comparison_key: nil, comparison_text: nil)
        card_key = id.to_s

        title = resolve_title(card_key, title_key)
        unit = resolve_unit(card_key, unit_key)
        comparison_text ||= resolve_comparison_text(card_key, comparison_key)

        percentage_change = calculate_percentage_change(current, previous)
        trend = determine_trend(current, previous)

        Metricdeck::MetricCard.new(
          id: id,
          title: title,
          value: value.to_s,
          unit: unit,
          comparison_percentage: percentage_change,
          trend: trend,
          comparison_text: comparison_text
        )
      end

      private

      def resolve_title(card_key, title_key)
        key = title_key || "metricdeck.cards.#{card_key}.title"
        I18n.t(key, default: card_key.humanize)
      end

      def resolve_unit(card_key, unit_key)
        if unit_key.is_a?(Symbol)
          I18n.t("metricdeck.units.#{unit_key}", default: '')
        elsif unit_key.present?
          I18n.t(unit_key, default: '')
        else
          I18n.t("metricdeck.cards.#{card_key}.unit", default: '')
        end
      end

      def resolve_comparison_text(card_key, comparison_key)
        default = I18n.t('metricdeck.comparisons.previous_period', default: 'vs previous period')
        if comparison_key.is_a?(Symbol)
          I18n.t("metricdeck.comparisons.#{comparison_key}", default: default)
        elsif comparison_key.present?
          I18n.t(comparison_key, default: default)
        else
          I18n.t("metricdeck.cards.#{card_key}.comparison", default: default)
        end
      end
    end
  end
end
