# frozen_string_literal: true

require 'rails_helper'
require 'tmpdir'
require 'fileutils'
require 'generators/metricdeck/calculator/calculator_generator'

RSpec.describe Metricdeck::Generators::CalculatorGenerator do
  around do |example|
    Dir.mktmpdir do |tmpdir|
      @tmpdir = tmpdir
      example.run
    end
  end

  def run_generator(args = %w[active_users])
    described_class.start(args, destination_root: @tmpdir)
  end

  def generated_file(path)
    File.read(File.join(@tmpdir, path))
  end

  def file_exists?(path)
    File.exist?(File.join(@tmpdir, path))
  end

  describe 'running the generator' do
    before { run_generator }

    it 'creates the calculator file' do
      expect(file_exists?('app/metrics/calculators/active_users_calculator.rb')).to be true
    end

    it 'contains the correct class definition' do
      expect(generated_file('app/metrics/calculators/active_users_calculator.rb'))
        .to include('class ActiveUsersCalculator')
    end

    it 'includes the base calculator module' do
      expect(generated_file('app/metrics/calculators/active_users_calculator.rb'))
        .to include('include Metricdeck::Calculators::BaseCalculator')
    end

    it 'includes the card helpers module' do
      expect(generated_file('app/metrics/calculators/active_users_calculator.rb'))
        .to include('include Metricdeck::Helpers::CardHelpers')
    end

    it 'defines validate_context method' do
      expect(generated_file('app/metrics/calculators/active_users_calculator.rb'))
        .to include('def validate_context')
    end

    it 'defines perform_calculation method' do
      expect(generated_file('app/metrics/calculators/active_users_calculator.rb'))
        .to include('def perform_calculation')
    end

    it 'calls create_metric_card' do
      expect(generated_file('app/metrics/calculators/active_users_calculator.rb'))
        .to include('create_metric_card')
    end
  end

  describe 'with a different name' do
    before { run_generator(%w[monthly_revenue]) }

    it 'creates the correctly named file' do
      expect(file_exists?('app/metrics/calculators/monthly_revenue_calculator.rb')).to be true
    end

    it 'uses the correct class name' do
      expect(generated_file('app/metrics/calculators/monthly_revenue_calculator.rb'))
        .to include('class MonthlyRevenueCalculator')
    end
  end
end
