# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Metricdeck::MetricCard do
  describe '#initialize' do
    it 'creates a card with all attributes' do
      card = described_class.new(
        id: 'users',
        title: 'Active Users',
        value: '42',
        unit: 'users',
        comparison_percentage: 10.5,
        trend: 'up',
        comparison_text: 'vs last month'
      )

      expect(card.id).to eq('users')
      expect(card.title).to eq('Active Users')
      expect(card.value).to eq('42')
      expect(card.unit).to eq('users')
      expect(card.comparison_percentage).to eq(10.5)
      expect(card.trend).to eq('up')
      expect(card.comparison_text).to eq('vs last month')
    end
  end

  describe '#comparison' do
    it 'returns a comparison hash' do
      card = described_class.new(
        comparison_percentage: 5.0,
        trend: 'down',
        comparison_text: 'vs previous period'
      )

      expect(card.comparison).to eq(
        'percentage' => 5.0,
        'trend' => 'down',
        'text' => 'vs previous period'
      )
    end
  end

  describe '#as_json' do
    it 'includes attributes and comparison in json output' do
      card = described_class.new(
        id: 'test',
        title: 'Test',
        value: '100',
        comparison_percentage: 0.0,
        trend: 'neutral',
        comparison_text: 'vs previous'
      )

      json = card.as_json
      expect(json['id']).to eq('test')
      expect(json['title']).to eq('Test')
      expect(json['value']).to eq('100')
      expect(json['comparison']).to eq(
        'percentage' => 0.0,
        'trend' => 'neutral',
        'text' => 'vs previous'
      )
    end
  end
end
