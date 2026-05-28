# frozen_string_literal: true

require 'active_model'
require 'active_support/all'

module Metricdeck
  class Error < StandardError; end

  require_relative 'metricdeck/version'
  require_relative 'metricdeck/metric_card'
  require_relative 'metricdeck/calculators/base_calculator'
  require_relative 'metricdeck/helpers/card_helpers'
  require_relative 'metricdeck/helpers/date_helpers'
  require_relative 'metricdeck/metric_card_service'
end
