# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Metricdeck::Calculators::BaseCalculator do
  let(:dummy_calculator) do
    Class.new do
      include Metricdeck::Calculators::BaseCalculator

      def perform_calculation(_context)
        'computed'
      end
    end
  end

  describe '#calculate' do
    it 'calls validate_context then perform_calculation' do
      instance = dummy_calculator.new
      expect(instance).to receive(:validate_context).with({ foo: :bar })
      expect(instance.calculate({ foo: :bar })).to eq('computed')
    end
  end

  describe '#card_id' do
    it 'derives id from class name' do
      klass = Class.new do
        include Metricdeck::Calculators::BaseCalculator
      end
      stub_const('Metrics::Calculators::LateArrivalsCalculator', klass)
      expect(klass.new.card_id).to eq('late_arrivals')
    end
  end

  describe '#perform_calculation' do
    it 'raises NotImplementedError by default' do
      klass = Class.new do
        include Metricdeck::Calculators::BaseCalculator
      end
      expect { klass.new.perform_calculation({}) }.to raise_error(NotImplementedError)
    end
  end
end
