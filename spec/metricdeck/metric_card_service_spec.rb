# frozen_string_literal: true

require 'rails_helper'

module DummyCalculators
  class TestCalculator
    include Metricdeck::Calculators::BaseCalculator
    include Metricdeck::Helpers::CardHelpers

    def perform_calculation(_context)
      create_metric_card(card_id, value: 10, current: 10, previous: 8)
    end
  end

  class AnotherCalculator
    include Metricdeck::Calculators::BaseCalculator
    include Metricdeck::Helpers::CardHelpers

    def perform_calculation(_context)
      create_metric_card(card_id, value: 20, current: 20, previous: 15)
    end
  end

  # Not a calculator — should be ignored
  class HelperClass
  end
end

RSpec.describe Metricdeck::MetricCardService do
  describe '#get_cards' do
    it 'returns all cards when no filter given' do
      service = described_class.new(namespace: DummyCalculators)
      cards = service.get_cards({})

      expect(cards.size).to eq(2)
      expect(cards.map(&:id)).to contain_exactly('test', 'another')
    end

    it 'filters by card type' do
      service = described_class.new(namespace: DummyCalculators)
      cards = service.get_cards({}, [:test])

      expect(cards.size).to eq(1)
      expect(cards.first.id).to eq('test')
    end
  end

  describe '#available_calculators' do
    it 'only includes classes ending in Calculator' do
      service = described_class.new(namespace: DummyCalculators)
      calculators = service.available_calculators

      expect(calculators.map(&:class).map(&:name)).to contain_exactly(
        'DummyCalculators::TestCalculator', 'DummyCalculators::AnotherCalculator'
      )
    end
  end

  describe '#available_card_types' do
    it 'returns card_ids as symbols' do
      service = described_class.new(namespace: DummyCalculators)
      expect(service.available_card_types).to contain_exactly(:test, :another)
    end
  end

  describe 'default namespace' do
    it 'raises when Metrics::Calculators is not defined' do
      expect { described_class.new.get_cards({}) }.to raise_error(ArgumentError, /No calculator namespace/)
    end
  end
end
