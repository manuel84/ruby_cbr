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

    def similarity(c, attr_name, attr_value)
      #('CBR::Similarity::'+@similarities[c.class.name][attr][:similarity]).constantize
      attr_config = @similarities[c.class.name][attr_name]
      max_distance = attr_config[:max_distance]
      class_name = 'CBR::Similarity::'+attr_config[:similarity]
      similarity_class = Object.const_get(class_name).new(max_distance: max_distance)
      similarity_class.compare(attr_value, c.send(attr_name))
    end

    def weighted_similarity(c, attr_name, attr_value)
      attr_config = @similarities[c.class.name][attr_name]
      weight = attr_config[:rel_weight]
      weight * similarity(c, attr_name, attr_value)
    end

  end
end
