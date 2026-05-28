# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Metricdeck::Helpers::DateHelpers do
  let(:helper_class) do
    Class.new do
      include Metricdeck::Helpers::DateHelpers
    end
  end

  let(:helper) { helper_class.new }

  describe '#parse_date_with_formats' do
    it 'parses dd-mm-yyyy' do
      expect(helper.parse_date_with_formats('15-01-2025')).to eq(Date.new(2025, 1, 15))
    end

    it 'parses yyyy-mm-dd' do
      expect(helper.parse_date_with_formats('2025-01-15')).to eq(Date.new(2025, 1, 15))
    end

    it 'returns nil for blank' do
      expect(helper.parse_date_with_formats(nil)).to be_nil
      expect(helper.parse_date_with_formats('')).to be_nil
    end

    it 'returns Date as-is' do
      date = Date.new(2025, 1, 15)
      expect(helper.parse_date_with_formats(date)).to eq(date)
    end
  end

  describe '#calculate_previous_period' do
    it 'shifts by period length for :previous' do
      start_date = Date.new(2025, 1, 1)
      end_date = Date.new(2025, 1, 10)

      prev_start, prev_end = helper.calculate_previous_period(start_date, end_date, :previous)
      expect(prev_start).to eq(Date.new(2024, 12, 22))
      expect(prev_end).to eq(Date.new(2024, 12, 31))
    end

    it 'shifts by month for :last_month' do
      start_date = Date.new(2025, 2, 1)
      end_date = Date.new(2025, 2, 15)

      prev_start, prev_end = helper.calculate_previous_period(start_date, end_date, :last_month)
      expect(prev_start).to eq(Date.new(2025, 1, 1))
      expect(prev_end).to eq(Date.new(2025, 1, 15))
    end

    it 'shifts by year for :last_year' do
      start_date = Date.new(2025, 3, 10)
      end_date = Date.new(2025, 3, 20)

      prev_start, prev_end = helper.calculate_previous_period(start_date, end_date, :last_year)
      expect(prev_start).to eq(Date.new(2024, 3, 10))
      expect(prev_end).to eq(Date.new(2024, 3, 20))
    end
  end

  describe '#generate_comparison_text' do
    it 'returns last_month text' do
      expect(helper.generate_comparison_text(:last_month)).to eq('vs last month')
    end

    it 'returns last_year text' do
      expect(helper.generate_comparison_text(:last_year)).to eq('vs last year')
    end

    it 'returns previous_period text by default' do
      expect(helper.generate_comparison_text(:previous)).to eq('vs previous period')
    end
  end
end
