# frozen_string_literal: true

require 'spec_helper'

require 'rails'
require 'active_record'
require 'active_model'
require 'action_controller'
require 'i18n'

require 'metricdeck'

# Configure a minimal Rails application for testing
module TestApp
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f
    config.eager_load = false
    config.cache_classes = true
    config.consider_all_requests_local = true
    config.secret_key_base = 'test_secret_key_base'
    config.api_only = true

    begin
      config.middleware.delete ActionDispatch::Cookies
      config.middleware.delete ActionDispatch::Session::CookieStore
      config.middleware.delete ActionDispatch::Flash
    rescue StandardError
      # ignore
    end
  end
end

TestApp::Application.initialize! unless Rails.application

# Set up I18n with test translations
I18n.backend.store_translations(:en,
                                metricdeck: {
                                  cards: {
                                    test_metric: {
                                      title: 'Test Metric',
                                      unit: 'items'
                                    }
                                  },
                                  comparisons: {
                                    previous_period: 'vs previous period',
                                    last_month: 'vs last month',
                                    last_year: 'vs last year'
                                  }
                                })
