# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Metricdeck::Helpers::CardHelpers do
  let(:helper_class) do
    Class.new do
      include Metricdeck::Helpers::CardHelpers
    end
  end

  let(:helper) { helper_class.new }

  describe '#calculate_percentage_change' do
    it 'calculates positive change' do
      expect(helper.calculate_percentage_change(110, 100)).to eq(10.0)
    end

    it 'calculates negative change' do
      expect(helper.calculate_percentage_change(90, 100)).to eq(-10.0)
    end

    it 'returns 0 when previous is zero' do
      expect(helper.calculate_percentage_change(10, 0)).to eq(0)
    end
  end

  describe '#determine_trend' do
    it 'returns up when current > previous' do
      expect(helper.determine_trend(10, 5)).to eq('up')
    end

    it 'returns down when current < previous' do
      expect(helper.determine_trend(5, 10)).to eq('down')
    end

    it 'returns neutral when equal' do
      expect(helper.determine_trend(5, 5)).to eq('neutral')
    end

    it 'returns neutral when previous is zero' do
      expect(helper.determine_trend(5, 0)).to eq('neutral')
    end
  end

  describe '#create_metric_card' do
    it 'creates a MetricCard with resolved i18n' do
      card = helper.create_metric_card(
        :test_metric,
        value: 42,
        current: 42,
        previous: 40
      )

      expect(card).to be_a(Metricdeck::MetricCard)
      expect(card.id).to eq('test_metric')
      expect(card.title).to eq('Test Metric')
      expect(card.unit).to eq('items')
      expect(card.value).to eq('42')
      expect(card.comparison_percentage).to eq(5.0)
      expect(card.trend).to eq('up')
    end
  end
end
