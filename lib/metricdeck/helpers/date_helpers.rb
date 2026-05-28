# frozen_string_literal: true

module Metricdeck
  module Helpers
    module DateHelpers
      def parse_date_with_formats(date_str)
        return nil if date_str.blank?
        return date_str if date_str.is_a?(Date)

        formats = ['%d-%m-%Y', '%Y-%m-%d', '%m/%d/%Y', '%d/%m/%Y']

        formats.each do |format|
          return Date.strptime(date_str.to_s, format)
        rescue Date::Error
          next
        end

        begin
          Date.parse(date_str.to_s)
        rescue Date::Error
          nil
        end
      end

      def calculate_previous_period(start_date, end_date, comparison_period = :previous)
        period_length = (end_date - start_date).to_i + 1

        case comparison_period.to_sym
        when :month, :last_month
          prev_start_date = start_date.prev_month
          prev_end_date = [end_date.prev_month, prev_start_date.end_of_month].min
        when :year, :last_year
          prev_start_date = start_date.prev_year
          prev_end_date = end_date.prev_year
        else
          prev_start_date = start_date - period_length.days
          prev_end_date = end_date - period_length.days
        end

        [prev_start_date, prev_end_date]
      end

      def generate_comparison_text(comparison_period)
        period = comparison_period.to_sym if comparison_period.respond_to?(:to_sym)

        comparison_key = case period
                         when :month, :last_month
                           :last_month
                         when :year, :last_year
                           :last_year
                         else
                           :previous_period
                         end

        I18n.t("metricdeck.comparisons.#{comparison_key}")
      end
    end
  end
end
