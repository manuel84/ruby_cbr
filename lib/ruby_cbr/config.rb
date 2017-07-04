require 'singleton'

module CBR
  class Config
    include Singleton

    attr_accessor :similarities

    def initialize
      @similarities = {}
      @similarities.default = {
          'Tweet': {
              similarity: 'StringSimilarity',
              weight: 1,
              values: nil,
              max_distance: 2,
              default: '',
              display_name: '(not set)',
              display_type: 'text'
          }
      }
    end

    def calculate_relative_weights
      total_weights = @similarities.values.map {|attributes| attributes.values}.flatten.reduce(BigDecimal.new('0.0')) do |memo, attribute|
        memo += attribute[:weight]
      end
      @similarities.each do |model_name, attributes|
        attributes.each do |attr_name, attr_values|
          attr_values[:weight] = BigDecimal.new(attr_values[:weight])
          attr_values[:rel_weight] = attr_values[:weight] / total_weights
        end
      end
      @similarities
    end

    def similarity(c, attr)
      #('CBR::Similarity::'+@similarities[c.class.name][attr][:similarity]).constantize
      max_distance = @similarities[c.class.name][attr][:max_distance]
      Object.const_get('CBR::Similarity::'+@similarities[c.class.name][attr][:similarity]).new(max_distance: max_distance)
    end

  end
end
