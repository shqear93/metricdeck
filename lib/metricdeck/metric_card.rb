# frozen_string_literal: true

module Metricdeck
  class MetricCard
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Serialization

    attribute :id, :string
    attribute :title, :string
    attribute :value, :string
    attribute :unit, :string
    attribute :comparison_percentage, :float
    attribute :trend, :string
    attribute :comparison_text, :string

    def initialize(attributes = {})
      super
    end

    def comparison
      {
        'percentage' => comparison_percentage,
        'trend' => trend,
        'text' => comparison_text
      }
    end

    def as_json(_options = nil)
      attributes.compact.merge('comparison' => comparison)
    end
  end
end
