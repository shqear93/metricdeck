# frozen_string_literal: true

require 'rails/generators'

module Metricdeck
  module Generators
    class CalculatorGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      desc 'Creates a new metric calculator'

      def create_calculator_file
        template 'calculator.rb.tt', "app/metrics/calculators/#{file_name}_calculator.rb"
      end
    end
  end
end
