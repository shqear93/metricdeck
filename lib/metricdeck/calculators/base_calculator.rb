# frozen_string_literal: true

module Metricdeck
  module Calculators
    module BaseCalculator
      def calculate(context)
        validate_context(context)
        perform_calculation(context)
      end

      def perform_calculation(_context)
        raise NotImplementedError, "#{self.class} must implement #perform_calculation"
      end

      def card_id
        self.class.name.demodulize.underscore.sub(/_calculator$/, '')
      end

      protected

      def validate_context(_context)
        # Override in subclasses
      end
    end
  end
end
