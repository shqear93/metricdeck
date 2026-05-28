# frozen_string_literal: true

module Metricdeck
  class MetricCardService
    attr_reader :namespace

    def initialize(namespace: nil)
      @namespace = namespace || default_namespace
    end

    def get_cards(context, card_types = nil)
      calculators = available_calculators

      calculators = calculators.select { |c| card_types.include?(c.card_id.to_sym) } if card_types.present?

      calculators.map { |calculator| calculator.calculate(context) }
    end

    def available_calculators
      calculators = []

      namespace.constants.each do |const_name|
        const = namespace.const_get(const_name)

        next unless const.is_a?(Class) &&
                    const.included_modules.include?(Metricdeck::Calculators::BaseCalculator) &&
                    const_name.to_s.end_with?('Calculator')

        calculators << const.new
      end

      calculators
    end

    def available_card_types
      available_calculators.map { |c| c.card_id.to_sym }
    end

    private

    def default_namespace
      if Object.const_defined?(:Metrics) && ::Metrics.const_defined?(:Calculators)
        ::Metrics::Calculators
      else
        raise ArgumentError,
              'No calculator namespace provided and Metrics::Calculators is not defined. ' \
              'Pass namespace: MyApp::Metrics::Calculators to MetricCardService.new'
      end
    end
  end
end
